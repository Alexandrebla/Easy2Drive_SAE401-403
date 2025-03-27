<?php
require_once "../config/database.php";

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['id'])) {
        $idTest = $_GET['id'];

        $query = "
            SELECT t.id_test, t.nom_test, t.date_test, t.resultat, e.id_examen, e.nom_examen, e.date_examen
            FROM test t
            JOIN examen e ON t.id_examen = e.id_examen
            WHERE t.id_test = :idTest
        ";

        try {
            $stmt = $pdo->prepare($query);
            $stmt->execute([':idTest' => $idTest]);
            $test = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($test) {
                echo json_encode(['success' => true, 'test' => $test]);
            } else {
                http_response_code(404);
                echo json_encode(['success' => false, 'message' => 'Test non trouvé']);
            }
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
        }
    } else {
        $query = "
            SELECT t.id_test, t.nom_test, t.date_test, t.resultat, e.id_examen, e.nom_examen, e.date_examen
            FROM test t
            JOIN examen e ON t.id_examen = e.id_examen
        ";

        try {
            $stmt = $pdo->query($query);
            $tests = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode(['success' => true, 'tests' => $tests]);
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
        }
    }
}
?>
