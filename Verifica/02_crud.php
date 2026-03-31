<?php

// SELECT


$result = mysqli_query($conn, "SELECT * FROM tabella");

if ($result === false)
    exit("Errore query: " . mysqli_error($conn));

// Procedurale
while ($row = mysqli_fetch_assoc($result)) {
    echo $row["colonna"];
}

// OOP
while ($row = $result->fetch_assoc()) {
    echo $row["colonna"];
}

mysqli_free_result($result);


// SELECT — WHERE


$titolo = $_GET["titolo"];
$result = mysqli_query($conn, "SELECT * FROM libri WHERE titolo = '$titolo'");

if ($result && mysqli_num_rows($result) > 0) {
    while ($row = $result->fetch_assoc())
        echo $row["titolo"];
} else {
    echo "Nessun risultato.";
}


// SELECT — ORDER BY


$ordine = isset($_GET["ordine"]) ? $_GET["ordine"] : "ASC";
$result = mysqli_query($conn, "SELECT * FROM tabella ORDER BY colonna $ordine");


// SELECT — COUNT


$result = mysqli_query($conn, "SELECT COUNT(*) AS totale FROM tabella");
$row    = mysqli_fetch_assoc($result);

if ($row["totale"] == 0) {
    header("Location: aggiungi.php");
    exit;
}


// SELECT — QUERY ANNIDATA (join manuale)


while ($row = $result->fetch_assoc()) {
    $id_autore = $row["id_autori"];
    $autore    = mysqli_query($conn, "SELECT nome, cognome FROM autori WHERE id = $id_autore")->fetch_assoc();
    echo $autore["nome"] . " " . $autore["cognome"];
}


// INSERT


$titolo = @$_GET["titolo"];
$prezzo = @$_GET["prezzo"];
$ISBN   = @$_GET["ISBN"];

$sql = "INSERT INTO libri (titolo, prezzo, ISBN) VALUES ('$titolo', '$prezzo', '$ISBN')";

if (isset($_GET["titolo"])) {
    if ($conn->query($sql) === TRUE) {
        header("Location: index.php");
        exit;
    } else {
        echo "Errore: " . $conn->error;
    }
}

// UPDATE


if (isset($_GET["salva"])) {
    $id     = $_GET["id"];
    $titolo = $_GET["titolo"];
    $prezzo = $_GET["prezzo"];

    $sql    = "UPDATE libri SET titolo='$titolo', prezzo='$prezzo' WHERE id='$id'";
    $result = mysqli_query($conn, $sql);

    if ($result === false)
        exit("Errore UPDATE: " . mysqli_error($conn));

    header("Location: index.php");
    exit;
}


// DELETE


if (isset($_GET["id"])) {
    $id = $_GET["id"];
    mysqli_query($conn, "DELETE FROM tabella WHERE id = '$id'");
}

header("Location: index.php");
exit;
