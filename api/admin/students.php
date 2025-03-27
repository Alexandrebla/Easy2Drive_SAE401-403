<?php
// Headers pour CORS et type de contenu
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json; charset=UTF-8");

// Si c'est une requête OPTIONS, on arrête ici
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// On inclut notre fichier de connexion à la base de données
require_once "../config/database.php";

try {
    // Récupérer la liste des étudiants
    if($_SERVER['REQUEST_METHOD'] === 'GET') {
        $query = "SELECT p.*, e.neph, e.date_inscription, e.etg, e.echec_etg 
                  FROM personne p 
                  JOIN etudiant e ON p.id_personne = e.id_personne";
        $stmt = $conn->prepare($query);
        $stmt->execute();
        echo json_encode([
            "success" => true,
            "students" => $stmt->fetchAll(PDO::FETCH_ASSOC)
        ]);
    }

    // Ajouter un étudiant
    if($_SERVER['REQUEST_METHOD'] === 'POST') {
        $data = json_decode(file_get_contents("php://input"));
        
        // Vérifier si le login existe déjà
        $check = "SELECT COUNT(*) FROM personne WHERE login = :login";
        $stmt = $conn->prepare($check);
        $stmt->execute([':login' => $data->login]);
        
        if($stmt->fetchColumn() > 0) {
            http_response_code(400);
            echo json_encode([
                "success" => false,
                "message" => "Ce login existe déjà"
            ]);
            exit;
        }
        
        // Insérer dans la table personne
        $query = "INSERT INTO personne (prenom, nom, date_naissance, login, password) 
                  VALUES (:prenom, :nom, :date_naissance, :login, :password)";
        $stmt = $conn->prepare($query);
        $stmt->execute([
            ':prenom' => $data->prenom,
            ':nom' => $data->nom,
            ':date_naissance' => $data->date_naissance,
            ':login' => $data->login,
            ':password' => $data->password
        ]);
        
        $id_personne = $conn->lastInsertId();
        
        // Insérer dans la table etudiant
        $query = "INSERT INTO etudiant (id_personne, neph, date_inscription, etg) 
                  VALUES (:id_personne, :neph, NOW(), 0)";
        $stmt = $conn->prepare($query);
        $stmt->execute([
            ':id_personne' => $id_personne,
            ':neph' => $data->neph
        ]);
        
        echo json_encode([
            "success" => true,
            "message" => "Étudiant ajouté avec succès"
        ]);
    }

    // Supprimer un étudiant
    if($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        if(!isset($_GET['id'])) {
            throw new Exception("ID manquant");
        }
        
        $id = $_GET['id'];
        
        // Supprimer de la table etudiant
        $query = "DELETE FROM etudiant WHERE id_personne = :id";
        $stmt = $conn->prepare($query);
        $stmt->execute([':id' => $id]);
        
        // Supprimer de la table personne
        $query = "DELETE FROM personne WHERE id_personne = :id";
        $stmt = $conn->prepare($query);
        $stmt->execute([':id' => $id]);
        
        echo json_encode([
            "success" => true,
            "message" => "Étudiant supprimé avec succès"
        ]);
    }

} catch(Exception $e) {
    http_response_code(400);
    echo json_encode([
        "success" => false,
        "message" => $e->getMessage()
    ]);
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Erreur serveur: " . $e->getMessage()
    ]);
}
?>