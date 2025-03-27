<?php
require_once "../config/database.php";

// 🔹 Gérer les en-têtes CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Credentials: true");

// 🔹 Gérer la requête OPTIONS (préflight) AVANT TOUT
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit(); // ⚠️ Stoppe l'exécution pour ne pas continuer après
}

// 🔹 Lire les données JSON envoyées
$inputJSON = file_get_contents("php://input");
$input = json_decode($inputJSON, true);

// 🔹 Vérifier que la méthode est bien POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (
        isset($input['prenom'], $input['nom'], $input['neph'], 
              $input['date_inscription'], $input['etg'], $input['echec_etg'])
    ) {
        try {
            $pdo->beginTransaction();
            
            // Insérer la personne
            $queryPersonne = "INSERT INTO personne (prenom, nom) VALUES (:prenom, :nom)";
            $stmt = $pdo->prepare($queryPersonne);
            $stmt->execute([':prenom' => $input['prenom'], ':nom' => $input['nom']]);
            $idPersonne = $pdo->lastInsertId();
            
            // Insérer l'étudiant
            $queryEtudiant = "INSERT INTO etudiant (id_personne, neph, date_inscription, etg, echec_etg) 
                              VALUES (:id_personne, :neph, :date_inscription, :etg, :echec_etg)";
            $stmt = $pdo->prepare($queryEtudiant);
            $stmt->execute([
                ':id_personne' => $idPersonne,
                ':neph' => $input['neph'],
                ':date_inscription' => $input['date_inscription'],
                ':etg' => $input['etg'],
                ':echec_etg' => $input['echec_etg']
            ]);
            
            $pdo->commit();
            echo json_encode(['success' => true, 'message' => 'Étudiant ajouté avec succès']);
        } catch (PDOException $e) {
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
