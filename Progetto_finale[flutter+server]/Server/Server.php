<?php 
echo "42"

function registrazione($none,$password){
    if (/* se risultato della query x nome esiste gia */) {
        return "un account con questo nome esiste già";
    }else {
        //creazione account
        return "successo";
    }
}
function autenticazione($none,$password){
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