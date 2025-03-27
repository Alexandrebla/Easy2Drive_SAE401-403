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
    $stmt = $pdo->prepare("SELECT * FROM personne WHERE login = :login");
    $stmt->execute(['login' => $login]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    // DEBUG : log dans fichier local
    file_put_contents(__DIR__ . '/debug.txt', print_r([
        'login_reçu' => $login,
        'password_reçu' => $password,
        'user_trouvé' => $user ?: 'aucun utilisateur'
    ], true));

    if ($user && password_verify($password, $user['password'])) {
        // Vérification du rôle
        $roleStmt = $pdo->prepare("SELECT 'admin' AS role FROM admin WHERE id_personne = :id
                                   UNION
                                   SELECT 'etu' AS role FROM etudiant WHERE id_personne = :id");
        $roleStmt->execute(['id' => $user['id_personne']]);
        $role = $roleStmt->fetchColumn();

        echo json_encode([
            'success' => true,
            'user' => [
                'id' => $user['id_personne'],
                'login' => $user['login'],
                'role' => $role ?: 'inconnu'
            ]
        ]);
    } else {
        http_response_code(401);

        // Log spécial si le login est bon mais le mot de passe échoue
        file_put_contents(__DIR__ . '/debug.txt', "\nMauvais mot de passe pour $login\n", FILE_APPEND);

        echo json_encode(['success' => false, 'message' => 'Login ou mot de passe incorrect']);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Erreur serveur : ' . $e->getMessage()]);
}
?>