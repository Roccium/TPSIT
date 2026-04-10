<?php
include $_SERVER['DOCUMENT_ROOT'] . '/Server/db.php';
header('Content-Type: application/json');
$messaggio = json_decode(file_get_contents("php://input"), true);

$nome = "";
$password = "";
$idfoto = "";                                     
if (isset($messaggio['nome']) && isset($messaggio['password'])) {
    $nome = $messaggio['nome'];         
    $password = $messaggio['password']; 
}
if (isset($messaggio['idfoto'])) {
    $idfoto = $messaggio['idfoto'];
}
$azione = $messaggio['azione'] ?? '';

switch ($azione) {
    case 'utente':
        echo json_encode(["message" => deleteuser($nome, $password)]);
        break;

    case 'foto':
        echo json_encode(["message" => deletefoto($idfoto)]);
        break;

    default:
        http_response_code(400);
        echo json_encode(["error" => "Azione non riconosciuta"]);
        break;
}

// ─── Funzioni ────────────────────────────────────────────────────────────────

    function deleteuser($nomeUtente,$passwordUtente){
        //password da hashare
        //statement da sistemare son merda
        $statement = $mysqli->prepare("DELETE FROM utenti WHERE nome = ? AND password = ?;");
        $statement->bind_param('ss',$nomeUtente,$passwordUtente);
        $statement->execute();
        //settagio cascade nel database
    }
    function deletefoto($codicefoto){
        //sistemare logica
        //le immagini verranno salvate come un path nella db e dentro una cartella
        $query = $mysqli->prepare("SELECT path FROM foto WHERE codicefoto = ?;");
        $query->bind_param('s',$codicefoto);
        $result=$query->execute();
        unlink($result);
        //fare delete del file della cartella

        $query = $mysqli->prepare("DELETE FROM foto WHERE codicefoto = ?;");
        $query->bind_param('s',$codicefoto);
        $query->execute();
        //cancelli la tupla
    }
?>
