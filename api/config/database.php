<?php
$host = 'mysql-marwantom.alwaysdata.net';
$dbname = 'marwantom_12';
$username = 'marwantom'; // ou 'marwantom_12' selon la config utilisateur MySQL
$password = 'Azertyqwerty.12'; // ← remplace-le par ton vrai mot de passe

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Erreur de connexion à la base de données : ' . $e->getMessage()
    ]);
    exit;
}
?>