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
if ($nome === '' || $password === '') {
    http_response_code(400);
    echo json_encode(["error" => "Nome e password obbligatori"]);
    exit;
}
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
        echo json_encode(["error" => "Azione non riconosciuta get"]);
        break;
}

// ─── Funzioni ────────────────────────────────────────────────────────────────
function registrazione(string $nom, string $pass){
    global $mysqli;

    if ($mysqli->connect_error) return 500;
    
    error_log("registrazione chiamata con nom=$nom");

    $value = $mysqli->prepare("SELECT nome FROM utenti WHERE nome = ?");
    if (!$value) {
        error_log("prepare fallito: " . $mysqli->error);
        return 500;
    }
    $value->bind_param('s', $nom);
    $value->execute();
    $value->bind_result($nomeEsistente);

    if ($value->fetch()) {
        http_response_code(409);
        return "utente esistente";
    }
    $value->close();

    $hash = password_hash($pass, PASSWORD_BCRYPT);
    $query = $mysqli->prepare("INSERT INTO utenti (nome, password) VALUES (?, ?)");
    if (!$query) {
        http_response_code(500);
        return "INSERT fallito";
    }
    $query->bind_param('ss', $nom, $hash);
    
    if (!$query->execute()) {
        http_response_code(500);
        return "EXECUTE fallito";
    }
        http_response_code(200);
    return "SUCESSO";
}

function autenticazione(string $nom, string $pass){
    global $mysqli;
    if (strpos($nom, " ") !== false){
        http_response_code(400);
        return "SPAZIO nel nome";
    };
    $query = $mysqli->prepare("SELECT password FROM utenti WHERE nome = ?");
    $query->bind_param('s', $nom);
    $query->execute();
    $query->bind_result($password);
    if (!$query->fetch()){
        http_response_code(401);
        return "UTENTE non esiste";
    };
    if (password_verify($pass,$password)) {
        http_response_code(200);
        return "SUCCESSO";
    }else{
        http_response_code(400);
        return "PASSWORD sbagliata";
    }
    
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
