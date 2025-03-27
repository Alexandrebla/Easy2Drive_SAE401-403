<?php
// Activer le debug pour développement
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// Connexion à la base
require_once __DIR__ . '/../config/database.php'; // chemin correct

// Lire les données reçues
$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['login'], $data['password'])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Login et mot de passe requis']);
    exit;
}

$login = $data['login'];
$password = $data['password'];

try {
    // Vérification dans la table Etudiant
    $stmt = $pdo->prepare("SELECT Id_Etudiant AS id, Login, Password, 'etudiant' AS role FROM Etudiant WHERE Login = :login
                           UNION
                           SELECT Id_Admin AS id, Login, Password, 'admin' AS role FROM Admin WHERE Login = :login");
    $stmt->execute(['login' => $login]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    file_put_contents(__DIR__ . '/debug_login.txt', print_r([
        'login_reçu' => $login,
        'password_reçu' => $password,
        'user_trouvé' => $user ?: 'aucun utilisateur',
    ], true), FILE_APPEND);

    if ($user && password_verify($password, $user['Password'])) {
        echo json_encode([
            'success' => true,
            'user' => [
                'id' => $user['id'],
                'login' => $user['Login'],
                'role' => $user['role']
            ]
        ]);
    } else {
        http_response_code(401);
        echo json_encode(['success' => false, 'message' => 'Login ou mot de passe incorrect']);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
}
