<?php
require_once "../config/database.php";

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Credentials: true");
header("Content-Type: application/json");

// Gérer la requête OPTIONS (pré-vérification CORS)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Vérifier si l'ID est fourni
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Lire les données JSON envoyées
    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data['id']) || !is_numeric($data['id'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'ID invalide ou manquant']);
        exit();
    }

    $idEtudiant = intval($data['id']);

    try {
        $pdo->beginTransaction();

        // Récupérer l'ID de la personne avant de supprimer l'étudiant
        $stmt = $pdo->prepare("SELECT id_personne FROM etudiant WHERE id_etudiant = :id");
        $stmt->execute([':id' => $idEtudiant]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$result) {
            http_response_code(404);
            echo json_encode(['success' => false, 'message' => 'Étudiant non trouvé']);
            exit();
        }

        $idPersonne = $result['id_personne'];

        // Supprimer l'étudiant
        $stmt = $pdo->prepare("DELETE FROM etudiant WHERE id_etudiant = :id");
        $stmt->execute([':id' => $idEtudiant]);

        // Vérifier s'il reste des étudiants associés à cette personne
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM etudiant WHERE id_personne = :idPersonne");
        $stmt->execute([':idPersonne' => $idPersonne]);
        $count = $stmt->fetchColumn();

        // Si aucun étudiant n'est associé, supprimer la personne
        if ($count == 0) {
            $stmt = $pdo->prepare("DELETE FROM personne WHERE id_personne = :idPersonne");
            $stmt->execute([':idPersonne' => $idPersonne]);
        }

        $pdo->commit();

        echo json_encode(['success' => true, 'message' => 'Étudiant supprimé avec succès']);
    } catch (PDOException $e) {
        $pdo->rollBack();
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
    }
}
?>
