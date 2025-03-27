<?php
require_once "../config/database.php";

// 🔹 Gérer les en-têtes CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Credentials: true");

// 🔹 Gérer la requête OPTIONS (préflight) AVANT TOUT
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// 🔹 Lire les données JSON envoyées
$inputJSON = file_get_contents("php://input");
$input = json_decode($inputJSON, true);

// 🔹 Vérifier que la méthode est bien PUT
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    if (
        isset($input['id_etudiant'], $input['prenom'], $input['nom'], $input['neph'], 
              $input['date_inscription'], $input['etg'], $input['echec_etg'])
    ) {
        try {
            $pdo->beginTransaction();
            
            // Récupérer l'ID de la personne associée à l'étudiant
            $queryGetPersonne = "SELECT id_personne FROM etudiant WHERE id_etudiant = :id_etudiant";
            $stmt = $pdo->prepare($queryGetPersonne);
            $stmt->execute([':id_etudiant' => $input['id_etudiant']]);
            $result = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$result) {
                throw new Exception("Étudiant introuvable");
            }

            $idPersonne = $result['id_personne'];

            // Mettre à jour la table personne
            $queryUpdatePersonne = "UPDATE personne SET prenom = :prenom, nom = :nom WHERE id_personne = :id_personne";
            $stmt = $pdo->prepare($queryUpdatePersonne);
            $stmt->execute([
                ':prenom' => $input['prenom'],
                ':nom' => $input['nom'],
                ':id_personne' => $idPersonne
            ]);

            // Mettre à jour la table étudiant
            $queryUpdateEtudiant = "UPDATE etudiant 
                                    SET neph = :neph, date_inscription = :date_inscription, etg = :etg, echec_etg = :echec_etg
                                    WHERE id_etudiant = :id_etudiant";
            $stmt = $pdo->prepare($queryUpdateEtudiant);
            $stmt->execute([
                ':neph' => $input['neph'],
                ':date_inscription' => $input['date_inscription'],
                ':etg' => $input['etg'],
                ':echec_etg' => $input['echec_etg'],
                ':id_etudiant' => $input['id_etudiant']
            ]);

            $pdo->commit();
            echo json_encode(['success' => true, 'message' => 'Étudiant mis à jour avec succès']);
        } catch (Exception $e) {
            $pdo->rollBack();
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
        }
    } else {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Données invalides']);
    }
} else {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Méthode non autorisée']);
}
?>
