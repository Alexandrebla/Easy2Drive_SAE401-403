<?php
require_once "../config/database.php";

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Récupérer les données envoyées (soit via JSON, soit via query string)
    $data = json_decode(file_get_contents("php://input"), true);

    if (isset($data['id'])) {
        $idAvis = $data['id'];

        $query = "DELETE FROM avis WHERE id_avis = :idAvis";

        try {
            $stmt = $pdo->prepare($query);
            $stmt->execute([':idAvis' => $idAvis]);

            if ($stmt->rowCount() > 0) {
                echo json_encode(['success' => true, 'message' => 'Avis supprimé avec succès']);
            } else {
                http_response_code(404);
                echo json_encode(['success' => false, 'message' => 'Avis non trouvé']);
            }
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
        }
    } else {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'ID de l\'avis manquant']);
    }
}
?>
