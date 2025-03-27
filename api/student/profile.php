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
            e.neph, e.date_inscription, e.etg, e.echec_etg,
            ae.nom AS auto_ecole_nom
        FROM personne p 
        JOIN etudiant e ON p.id_personne = e.id_personne
        LEFT JOIN appartient a ON e.id_etudiant = a.id_etudiant
        LEFT JOIN autoecole ae ON a.id_auto_ecole = ae.id_auto_ecole
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