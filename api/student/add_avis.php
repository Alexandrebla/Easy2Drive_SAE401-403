<?php
require_once "../config/database.php";

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Récupération des données envoyées en JSON
    $data = json_decode(file_get_contents("php://input"), true);

    if (isset($data['id_etudiant'], $data['contenu'], $data['note'], $data['titre'])) {
        $idEtudiant = $data['id_etudiant'];
        $contenu = $data['contenu'];
        $note = $data['note'];
        $titre = $data['titre'];
        $scoreAvis = isset($data['score_avis']) ? $data['score_avis'] : null;
        $statutModeration = isset($data['statut_moderation']) ? $data['statut_moderation'] : 'En attente';
        $dateDepot = date('Y-m-d');
        
        $query = "INSERT INTO avis (id_etudiant, contenu, note, date_depot, titre, score_avis, statut_moderation) 
                  VALUES (:id_etudiant, :contenu, :note, :date_depot, :titre, :score_avis, :statut_moderation)";

        try {
            $stmt = $pdo->prepare($query);
            $stmt->execute([
                ':id_etudiant' => $idEtudiant,
                ':contenu' => $contenu,
                ':note' => $note,
                ':date_depot' => $dateDepot,
                ':titre' => $titre,
                ':score_avis' => $scoreAvis,
                ':statut_moderation' => $statutModeration
            ]);
            
            echo json_encode(['success' => true, 'message' => 'Avis ajouté avec succès']);
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
        }
    } else {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Données incomplètes']);
    }
} else {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Méthode non autorisée']);
}
?>
