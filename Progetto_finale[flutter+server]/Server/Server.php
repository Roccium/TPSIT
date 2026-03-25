<?php 
$messaggio = json_decode("",true);
$nome = "";
$password="";
if (isset($messaggio['nome']) && isset($messaggio['password'])) {
$nome = $messaggio['nome']
$password = $messaggio['password']
}
//nel json avro tipo di messaggio e lo estraggo e faccio le chiamate adeguate
switch ($variable) {
    case 'value':
        # code...
        break;
    
    default:
        # code...
        break;
}
function registrazione($none,$password){
    if (/* se risultato della query x nome esiste gia */) {
        return "un account con questo nome esiste già";
    }else {
        //creazione account
        return "successo";
    }
}
function autenticazione($none,$password){
        //query x nome per vedere se esiste l'utente
        //query x $nome e password
        if (/*se la query va in errore */) {
            return "errore";
        }else{
            return "autenticato";
        }
}
function removebackground(){

}
function analize(){

}
?>