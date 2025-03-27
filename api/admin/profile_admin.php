<?php
require_once "../config/database.php";

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (!isset($_GET['id'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'ID manquant']);
        exit;
    }

    $id = $_GET['id'];

    $query = "
        SELECT 
            p.prenom, p.nom, p.date_naissance, p.login,
            a.administrateur_reseau
        FROM personne p 
        JOIN admin a ON p.id_personne = a.id_personne
        WHERE p.id_personne = :id
    ";

    try {
        $stmt = $pdo->prepare($query);
        $stmt->execute([':id' => $id]);
        $profil = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($profil) {
            echo json_encode(['success' => true, 'profil' => $profil]);
        } else {
            http_response_code(404);
            echo json_encode(['success' => false, 'message' => 'Profil non trouvé']);
        }
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
    }
}
?>
