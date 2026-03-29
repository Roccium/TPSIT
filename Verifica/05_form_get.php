<?php
// ════════════════════════════════════════
// LEGGERE $_GET / $_POST
// ════════════════════════════════════════

$valore = $_GET["chiave"];            // diretta
$valore = @$_GET["chiave"];           // @ sopprime warning se mancante
$valore = $_POST["chiave"];           // da form method="POST"

// Verifiche
if (isset($_GET["chiave"]))           echo $_GET["chiave"];
if (!empty($_GET["chiave"]))          echo "non vuoto";
if (isset($_GET["k"]) && !empty($_GET["k"])) echo "presente";

?>
<!-- ════════════════════════════════════════ -->
<!-- FORM BASE — method GET                   -->
<!-- ════════════════════════════════════════ -->
<form action="pagina.php" method="GET">
    <input type="text"   name="titolo"  value="<?= @$_GET['titolo'] ?>">
    <input type="number" name="prezzo"  value="<?= @$_GET['prezzo'] ?>">
    <input type="text"   name="ISBN">
    <input type="submit" name="salva" value="Salva">
    <input type="submit" name="logout" value="Logout">
</form>

<!-- ════════════════════════════════════════ -->
<!-- CAMPO HIDDEN — passa ID senza mostrarlo  -->
<!-- ════════════════════════════════════════ -->
<input type="hidden" name="id" value="<?= $_GET["id"] ?>">

<!-- ════════════════════════════════════════ -->
<!-- SELECT statico                           -->
<!-- ════════════════════════════════════════ -->
<select name="valuta">
    <option selected disabled>Scegli...</option>
    <option value="EUR">€</option>
    <option value="USD">$</option>
    <option value="GBP">£</option>
</select>

<!-- ════════════════════════════════════════ -->
<!-- SELECT dinamico da DB                    -->
<!-- ════════════════════════════════════════ -->
<?php
$result = mysqli_query($conn, "SELECT id, nome, cognome FROM autori");
?>
<select name="id_autore">
    <?php while ($row = mysqli_fetch_assoc($result)) { ?>
        <option value="<?= $row['id'] ?>">
            <?= $row['nome'] . ' ' . $row['cognome'] ?>
        </option>
    <?php } ?>
</select>

<!-- ════════════════════════════════════════ -->
<!-- TABELLA con link Elimina / Modifica      -->
<!-- ════════════════════════════════════════ -->
<table>
    <thead>
        <tr><th>ID</th><th>Titolo</th><th>Prezzo</th><th>Azioni</th></tr>
    </thead>
    <tbody>
        <?php while ($row = $result->fetch_assoc()) { ?>
        <tr>
            <td><?= $row["id"] ?></td>
            <td><?= $row["titolo"] ?></td>
            <td>€ <?= $row["prezzo"] ?></td>
            <td>
                <a href="elimina.php?id=<?= $row["id"] ?>"
                   onclick="return confirm('Eliminare?')">Elimina</a>

                <a href="modifica.php?id=<?= $row["id"] ?>&titolo=<?= $row["titolo"] ?>&prezzo=<?= $row["prezzo"] ?>">
                    Modifica</a>
            </td>
        </tr>
        <?php } ?>
    </tbody>
</table>

<!-- Pulsante redirect via JS -->
<input type="button" value="Vai" onclick="location='index.php?ordine=ASC'">
