<?php

// SESSION


session_start(); // SEMPRE prima di qualsiasi output HTML

// Scrivere
$_SESSION["username"] = "admin";
$_SESSION["ruolo"]    = "editor";

// Leggere
echo $_SESSION["username"];

// Verificare
if (isset($_SESSION["username"]))
    echo "Loggato come " . $_SESSION["username"];

// Eliminare una variabile
unset($_SESSION["username"]);

// Distruggere tutta la sessione
session_destroy();
session_abort(); // annulla modifiche correnti

// Debug
print_r($_SESSION);


// COOKIE


// Impostare (scade dopo 30 giorni)
setcookie("username", "admin", time() + (86400 * 30), "/");
// setcookie(nome, valore, scadenza, percorso)

// Leggere
echo $_COOKIE["username"];

// Eliminare (scadenza nel passato)
setcookie("username", "", time() - 3600);

// Verificare esistenza cookie
if (count($_COOKIE) > 0)
    echo "Cookie abilitati";
else
    echo "Cookie disabilitati";


// LOGIN + LOGOUT — flusso completo


session_start();

// Logout
if (isset($_GET["logout"])) {
    session_destroy();
    session_abort();
    setcookie("username", "", time() - 3600);
    setcookie("password", "", time() - 3600);
}

// Login
if (isset($_GET["username"]) && isset($_GET["password"])) {
    if ($_GET["username"] == "admin" && $_GET["password"] == "password") {
        $_SESSION["username"] = "admin";
        setcookie("username", "admin", time() + (86400 * 30), "/");
        header("Location: dashboard.php");
        exit;
    }
}

// Proteggere una pagina
if (!isset($_SESSION["username"])) {
    header("Location: login.php");
    exit;
}
