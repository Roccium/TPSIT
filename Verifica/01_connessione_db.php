<?php
// ════════════════════════════════════════
// CONNESSIONE DB
// ════════════════════════════════════════

// Procedurale
$conn = mysqli_connect("localhost", "root", "", "database");

// OOP — PHP 8 named args
$conn = mysqli_connect(
    hostname: "localhost",
    username: "root",
    password: "",
    database: "database"
);

// ────────────────────────────────────────
// CONTROLLO ERRORE
// ────────────────────────────────────────

// Procedurale
if (false === $conn)
    exit("Connessione fallita: " . mysqli_connect_error());

// OOP
if ($conn->connect_error)
    die("Connessione fallita: " . $conn->connect_error);

// ────────────────────────────────────────
// CHIUSURA
// ────────────────────────────────────────

mysqli_close($conn);
$conn->close();

// ────────────────────────────────────────
// DEBUG
// ────────────────────────────────────────

echo mysqli_get_host_info($conn);
