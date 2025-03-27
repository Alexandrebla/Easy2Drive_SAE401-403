<?php
require_once "../config/database.php";

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['id'])) {
        $idAvis = $_GET['id'];

        $query = "
            SELECT id_avis, id_etudiant, contenu, note, date_depot, titre, score_avis, statut_moderation
            FROM avis
            WHERE id_avis = :idAvis
        ";

        try {
            $stmt = $pdo->prepare($query);
            $stmt->execute([':idAvis' => $idAvis]);
            $avis = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($avis) {
                echo json_encode(['success' => true, 'avis' => $avis]);
            } else {
                http_response_code(404);
                echo json_encode(['success' => false, 'message' => 'Avis non trouvé']);
            }
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
        }
    } else {
        $query = "
            SELECT id_avis, id_etudiant, contenu, note, date_depot, titre, score_avis, statut_moderation
            FROM avis
        ";

        try {
            $stmt = $pdo->query($query);
            $avis = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode(['success' => true, 'avis' => $avis]);
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
        }
    }
}
?>
