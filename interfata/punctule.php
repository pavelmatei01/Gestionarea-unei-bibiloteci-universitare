<?php
// punctule.php (Varianta corectata pentru Oracle/Majuscule)
include 'db.php';

$message = "";
$error = "";

try {
    $db = getDbConnection();

    // --- LOGICA: STERGERE ---
    if (isset($_GET['delete_cod'])) {
        $cod_to_del = $_GET['delete_cod'];
        
        $stmt = $db->prepare("DELETE FROM Exemplar WHERE cod_bare = ?");
        $stmt->execute([$cod_to_del]);
        
        $message = "Exemplarul $cod_to_del a fost sters (impreuna cu imprumuturile sale).";
    }

    // --- PRELUARE DATE ---
    $stmt = $db->query("SELECT * FROM Exemplar ORDER BY cod_bare");
    $exemplare = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $stmt = $db->query("SELECT * FROM Imprumut ORDER BY cod_bare");
    $imprumuturi = $stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (Exception $e) {
    $error = "Eroare: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Exemplare & Imprumuturi</title>
    <style>
        body { font-family: sans-serif; }
        table { border-collapse: collapse; width: 45%; float: left; margin-right: 5%; }
        th, td { border: 1px solid #999; padding: 5px; text-align: center; }
        th { background-color: #eee; }
        .highlight { color: red; font-weight: bold; }
        .container { overflow: hidden; }
    </style>
</head>
<body>

    <a href="index.php">Inapoi</a>
    <hr>
    
    <h2>Testare ON DELETE CASCADE</h2>
    
    <?php if ($message): ?> <h3 style="color: green;"><?php echo $message; ?></h3> <?php endif; ?>
    <?php if ($error): ?> <h3 style="color: red;"><?php echo $error; ?></h3> <?php endif; ?>

    <div class="container">
        
        <div>
            <h3>Tabel: EXEMPLAR</h3>
            <table>
                <thead>
                    <tr>
                        <th>cod_bare (PK)</th>
                        <th>ISBN</th>
                        <th>id_sala</th>
                        <th>Actiune</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($exemplare as $ex): ?>
                    <tr>
                        <td class="highlight"><?php echo $ex['COD_BARE']; ?></td>
                        <td><?php echo $ex['ISBN']; ?></td>
                        <td><?php echo $ex['ID_SALA']; ?></td>
                        <td>
                            <a href="?delete_cod=<?php echo $ex['COD_BARE']; ?>" 
                               style="color: red;"
                               onclick="return confirm('Stergi exemplarul <?php echo $ex['COD_BARE']; ?>?');">
                               [X] Sterge
                            </a>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <div>
            <h3>Tabel: IMPRUMUT</h3>
            <p>Observa coloana <strong>cod_bare</strong>.</p>
            <table>
                <thead>
                    <tr>
                        <th>id_imprumut</th>
                        <th>id_student</th>
                        <th>cod_bare</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (empty($imprumuturi)): ?>
                        <tr><td colspan="3">Niciun imprumut.</td></tr>
                    <?php else: ?>
                        <?php foreach ($imprumuturi as $imp): ?>
                        <tr>
                            <td><?php echo $imp['ID_IMPRUMUT']; ?></td>
                            <td><?php echo $imp['ID_STUDENT']; ?></td>
                            <td class="highlight"><?php echo $imp['COD_BARE']; ?></td>
                        </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>

    </div>

</body>
</html>