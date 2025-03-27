<?php
require_once "../config/database.php";

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (!isset($_GET['id'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'ID étudiant manquant']);
        exit;
    }

    $idEtudiant = $_GET['id'];

    $query = "
        SELECT ex.id_examen, ex.theme, ex.date_examen, ex.nombre_questions, ex.score AS score_total
        FROM examens ex
        JOIN passeexamens pe ON pe.id_examen = ex.id_examen
        WHERE pe.id_etudiant = :idEtudiant
        ORDER BY ex.date_examen DESC
    ";

    try {
        $stmt = $pdo->prepare($query);
        $stmt->execute([':idEtudiant' => $idEtudiant]);
        $examens = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode(['success' => true, 'examens' => $examens]);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
    }
}
?>