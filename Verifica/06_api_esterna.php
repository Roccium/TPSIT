<?php
// ════════════════════════════════════════
// API ESTERNA — file_get_contents
// ════════════════════════════════════════

$url     = "https://api.esempio.com/dati";
$content = file_get_contents($url);

// ────────────────────────────────────────
// JSON → array PHP
// ────────────────────────────────────────

$result = json_decode($content, true); // true = array associativo
                                       // false/omesso = oggetto

// Accedere ai dati
echo $result["chiave"];
echo $result["dati"]["sotto_chiave"];

// ────────────────────────────────────────
// Array PHP → JSON
// ────────────────────────────────────────

$array = ["nome" => "Mario", "eta" => 30];
echo json_encode($array);

// ════════════════════════════════════════
// ESEMPIO REALE — convertitore valuta
// ════════════════════════════════════════

$base     = $_GET["valuta"];        // es. EUR
$target   = $_GET["datrasformare"]; // es. USD
$quantita = $_GET["quantita"];

$url     = "https://hexarate.paikama.co/api/rates/$base/$target/latest";
$content = file_get_contents($url);
$result  = json_decode($content, true);

$ratio = $result["data"]["mid"];

echo "$quantita $base = " . ($ratio * $quantita) . " $target";

// ════════════════════════════════════════
// API con contesto (header personalizzati)
// ════════════════════════════════════════

$options = [
    "http" => [
        "header" => "Authorization: Bearer TOKEN\r\nContent-Type: application/json\r\n",
        "method" => "GET",
    ]
];
$context = stream_context_create($options);
$content = file_get_contents($url, false, $context);
$result  = json_decode($content, true);

// ════════════════════════════════════════
// CONTROLLO ERRORI
// ════════════════════════════════════════

if ($content === false)
    exit("Errore: impossibile contattare l'API");

if (json_last_error() !== JSON_ERROR_NONE)
    exit("Errore JSON: " . json_last_error_msg());
