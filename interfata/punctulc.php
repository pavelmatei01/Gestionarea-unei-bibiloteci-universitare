<?php
// raport_complex_simplu.php
include 'db.php';

$rows = [];
$error_msg = '';

try {
    $db = getDbConnection();

    // SQL: Cărți de la edituri din RO cu autori din afara RO
    $sql = "SELECT 
                C.titlu AS Titlu_Carte, 
                ED.nume AS Editura, 
                A.nume AS Nume_Autor, 
                A.tara AS Tara_Autor
            FROM Carte C
            JOIN Editura ED ON C.id_editura = ED.id_editura
            JOIN Autor_Carte AC ON C.ISBN = AC.ISBN
            JOIN Autor A ON AC.id_autor = A.id_autor
            WHERE ED.tara = 'Romania' 
              AND A.tara != 'Romania'";

    $stmt = $db->query($sql);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (Exception $e) {
    $error_msg = "Eroare: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Raport Simplu</title>
</head>
<body>

    <a href="index.php">Înapoi la meniu</a>
    <h1>Raport: Cărți străine la edituri românești</h1>

    <?php if ($error_msg): ?>
        <p style="color: red;"><?= $error_msg ?></p>
    <?php endif; ?>

    <?php if (!empty($rows)): ?>
        <table border="1">
            <thead>
                <tr>
                    <?php 
                    // Luăm capul de tabel din cheile primului rând
                    foreach (array_keys($rows[0]) as $col): ?>
                        <th><?= str_replace('_', ' ', $col) ?></th>
                    <?php endforeach; ?>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($rows as $row): ?>
                    <tr>
                        <?php foreach ($row as $val): ?>
                            <td><?= htmlspecialchars($val ?? '-') ?></td>
                        <?php endforeach; ?>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <p>Total rânduri găsite: <?= count($rows) ?></p>
    <?php else: ?>
        <p>Nu s-au găsit date.</p>
    <?php endif; ?>

</body>
</html>