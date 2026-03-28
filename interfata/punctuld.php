<?php
// raport_studenti_activi_simplu.php
include 'db.php';

$rows = [];
$error_msg = '';

try {
    $db = getDbConnection();

    // SQL: Selectează studenții cu cel puțin 2 împrumuturi
    $sql = "SELECT 
                S.nume, 
                S.prenume, 
                COUNT(I.id_imprumut) AS Total_Carti
            FROM Student S
            JOIN Imprumut I ON S.id_student = I.id_student
            GROUP BY S.id_student, S.nume, S.prenume
            HAVING COUNT(I.id_imprumut) >= 2";

    $stmt = $db->query($sql);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (Exception $e) {
    $error_msg = "Eroare: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Raport Studenti Activi</title>
</head>
<body>

    <a href="index.php">Înapoi la meniu</a>
    <h1>Raport: Studenți cu minim 2 cărți împrumutate</h1>

    <?php if ($error_msg): ?>
        <p style="color: red;"><?= $error_msg ?></p>
    <?php endif; ?>

    <?php if (!empty($rows)): ?>
        <table border="1">
            <thead>
                <tr>
                    <th>Nume</th>
                    <th>Prenume</th>
                    <th>Total Cărți Împrumutate</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($rows as $row): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['NUME']) ?></td>
                        <td><?= htmlspecialchars($row['PRENUME']) ?></td>
                        <td style="text-align:center;"><b><?= $row['TOTAL_CARTI'] ?></b></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <p>Total rânduri: <?= count($rows) ?></p>
    <?php else: ?>
        <p>Nu s-au găsit studenți activi conform criteriului.</p>
    <?php endif; ?>

</body>
</html>