<?php
include __DIR__ . '/../db.php';
header('Content-Type: application/json');
$messaggio = json_decode(file_get_contents("php://input"), true);

$nome = "";
$password = "";

if (isset($messaggio['nome']) && isset($messaggio['password'])) {
    $nome = $messaggio['nome'];      
    $password = $messaggio['password']; 
}

$azione = $messaggio['azione'] ?? '';

switch ($azione) {
    

    default:
        http_response_code(400);
        echo json_encode(["error" => "Azione non riconosciuta patch"]);
        break;
}

// ─── Funzioni ────────────────────────────────────────────────────────────────



?>
