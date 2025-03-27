<?php
require_once "../config/database.php";

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['id'])) {
        $idEtudiant = $_GET['id'];

        $query = "
            SELECT e.id_etudiant, p.prenom, p.nom, e.neph, e.date_inscription, e.etg, e.echec_etg
            FROM etudiant e
            JOIN personne p ON e.id_personne = p.id_personne
            WHERE e.id_etudiant = :idEtudiant
        ";

        try {
            $stmt = $pdo->prepare($query);
            $stmt->execute([':idEtudiant' => $idEtudiant]);
            $etudiant = $stmt->fetch(PDO::FETCH_ASSOC);

            var_dump($etudiants); // Debug : Vérifier les données
            if ($etudiant) {
                echo json_encode(['success' => true, 'etudiant' => $etudiant]);
            } else {
                http_response_code(404);
                echo json_encode(['success' => false, 'message' => 'Étudiant non trouvé']);
            }
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
        }
    } else {
        $query = "
            SELECT e.id_etudiant, p.prenom, p.nom, e.neph, e.date_inscription, e.etg, e.echec_etg
            FROM etudiant e
            JOIN personne p ON e.id_personne = p.id_personne
        ";

        try {
            $stmt = $pdo->query($query);
            $etudiants = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode(['success' => true, 'etudiants' => $etudiants]);
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
        }
    }
}
?>
