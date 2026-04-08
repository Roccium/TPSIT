<?php
// ════════════════════════════════════════
// DATE E ORA
// ════════════════════════════════════════

echo date("d/m/Y");                   // 29/03/2026
echo date("H:i:s");                   // 14:35:00
echo date("d/m/Y H:i", time());       // data + ora corrente
echo date("m/d/Y h:i", time()-9000);  // sottrarre secondi

// Timestamp
echo time();                          // secondi dal 1/1/1970
echo time() + (86400 * 30);          // +30 giorni

// ════════════════════════════════════════
// REDIRECT
// ════════════════════════════════════════

header("Location: index.php");
exit; // sempre dopo header()

header("Location: pagina.php?id=5&msg=ok");
exit;

// ════════════════════════════════════════
// ISSET / EMPTY
// ════════════════════════════════════════

isset($var)                  // esiste e non è null
empty($var)                  // vuota, null, 0, "", false
!empty($var)                 // ha un valore utile
isset($var) && !empty($var)  // esiste ed ha valore

// ════════════════════════════════════════
// OPERATORE TERNARIO
// ════════════════════════════════════════

$x = condizione ? "vero" : "falso";

$ordine = isset($_GET["ordine"]) ? $_GET["ordine"] : "ASC";

// Toggle
$ordine = ($ordine == "ASC") ? "DESC" : "ASC";

// Null coalescing (PHP 7+)
$valore = $_GET["chiave"] ?? "default";

// ════════════════════════════════════════
// STRINGHE UTILI
// ════════════════════════════════════════

echo strlen("testo");          // lunghezza
echo strtolower("TESTO");      // minuscolo
echo strtoupper("testo");      // maiuscolo
echo trim("  testo  ");        // rimuove spazi
echo str_replace("a","b","ab"); // sostituisce
echo substr("testo", 0, 3);    // sottostringa

// ════════════════════════════════════════
// ARRAY UTILI
// ════════════════════════════════════════

$arr = [1, 2, 3];
count($arr);              // numero elementi
in_array(2, $arr);        // true
array_push($arr, 4);      // aggiunge in fondo
array_merge($arr, [5,6]); // unisce array

// ════════════════════════════════════════
// HASH PASSWORD
// ════════════════════════════════════════

$hash = hash("sha256", "password");
$hash = password_hash("password", PASSWORD_BCRYPT);
$ok   = password_verify("password", $hash); // true/false

// ════════════════════════════════════════
// DIE / EXIT
// ════════════════════════════════════════

die("Messaggio errore");   // stampa e termina
exit("Messaggio errore");  // identico a die()
exit;                      // termina senza output
