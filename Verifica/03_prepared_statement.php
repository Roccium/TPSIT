<?php
// ════════════════════════════════════════
// PREPARED STATEMENT — anti SQL injection
// ════════════════════════════════════════

$conn = new mysqli("localhost", "root", "", "database");

// ────────────────────────────────────────
// SENZA prepared statement (VULNERABILE)
// ────────────────────────────────────────

// ' OR 1=1 -- dentro $user bypassa il login
$query = $conn->query("SELECT * FROM login WHERE user='$user' AND password='$password'");

// ────────────────────────────────────────
// PASSWORD — hashing
// ────────────────────────────────────────

$password = hash("sha256", "testo");          // sha256
$password = password_hash("testo", PASSWORD_BCRYPT); // bcrypt (consigliato)
$ok       = password_verify("testo", $hash); // true/false

// ════════════════════════════════════════
// SELECT con prepared statement
// ════════════════════════════════════════

$user     = $_POST["user"];
$password = hash("sha256", $_POST["password"]);

$query = $conn->prepare("SELECT * FROM login WHERE user = ? AND password = ?");
//                                                        ↑ placeholder

$query->bind_param("ss", $user, $password);
// Tipi: "s" stringa | "i" intero | "d" double | "b" BLOB
// Ordine bind = ordine dei ? nella query

$query->execute();
$result = $query->get_result();

if ($result->num_rows > 0) {
    echo "Login ok";
} else {
    echo "Credenziali errate";
}

// ════════════════════════════════════════
// INSERT con prepared statement
// ════════════════════════════════════════

$titolo = $_POST["titolo"];
$prezzo = $_POST["prezzo"];
$ISBN   = $_POST["ISBN"];

$query = $conn->prepare("INSERT INTO libri (titolo, prezzo, ISBN) VALUES (?, ?, ?)");
$query->bind_param("sds", $titolo, $prezzo, $ISBN);
$query->execute();

// ════════════════════════════════════════
// UPDATE con prepared statement
// ════════════════════════════════════════

$titolo = $_POST["titolo"];
$id     = $_POST["id"];

$query = $conn->prepare("UPDATE libri SET titolo = ? WHERE id = ?");
$query->bind_param("si", $titolo, $id);
$query->execute();

// ════════════════════════════════════════
// DELETE con prepared statement
// ════════════════════════════════════════

$id    = $_POST["id"];
$query = $conn->prepare("DELETE FROM libri WHERE id = ?");
$query->bind_param("i", $id);
$query->execute();

// ────────────────────────────────────────
// CHIUSURA
// ────────────────────────────────────────

$query->close();
$conn->close();
