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
if (isset($messaggio['id_fotos'])) {
    $fotos = $messaggio['id_fotos'];
}
$azione = $messaggio['azione'] ?? '';

switch ($azione) {
    

    case 'primaconessione':
        echo json_encode(["message" => primaconessione($nome, $fotos)]);
        break;
    default:
        http_response_code(400);
        echo json_encode(["error" => "Azione non riconosciuta get"]);
        break;
}

// ─── Funzioni ────────────────────────────────────────────────────────────────
