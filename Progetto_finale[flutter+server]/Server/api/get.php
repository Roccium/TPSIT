<?php
include $_SERVER['DOCUMENT_ROOT'] . '/Server/db.php';
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
    case 'registrazione':
        echo json_encode(["message" => registrazione($nome, $password)]);
        break;

    case 'autenticazione':
        echo json_encode(["message" => autenticazione($nome, $password)]);
        break;

    case 'primaconessione':
        echo json_encode(["message" => primaconessione($nome, $fotos)]);
        break;
    default:
        http_response_code(400);
        echo json_encode(["error" => "Azione non riconosciuta"]);
        break;
}

// ─── Funzioni ────────────────────────────────────────────────────────────────

function registrazione($nom,$pass){
    //decidere come strutturare utenti
    $query = $mysqli->prepare("INSERT INTO utenti VALUES ( ?, ?); ;");
    $query->bind_param('ss',$nom,$pass);
}
function primaconessione($nom,$listaJson){
        $query = $mysqli->prepare("SELECT id_foto FROM `foto` INNER JOIN utenti ON foto.id_utente = utenti.ID WHERE utenti.nome = ?");
        $query->bind_param('s',$nom,$pass);
        $result=$query->execute();
        $listaSQL = [];
        while ($row = $result->fetch_assoc()) {
            $listaSQL[] = $row['link'];
        }
        $soloInJson = array_diff($listaJson, $listaSQL);
        if (empty($soloInJson)) {
            return "tutto aggiornato";
        }
        else{
            //devi andarti a prendere le immagine inserirle in json e mandarle
        }
        
}
?>
