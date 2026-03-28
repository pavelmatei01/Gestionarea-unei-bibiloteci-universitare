<?php
// afisare_views.php - Varianta Simplificata
include 'db.php';

$message = "";
$error = "";

try {
    $db = getDbConnection();

    // --- LOGICA LMD: UPDATE PE VIEW COMPUS ---
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_email'])) {
        $id_student = $_POST['id_student'];
        $email_nou = $_POST['email_nou'];

        if (!filter_var($email_nou, FILTER_VALIDATE_EMAIL)) {
            $error = "Format email invalid!";
        } else {
            // Executam UPDATE direct pe view
            $sql = "UPDATE V_Studenti_Info SET email = :email WHERE id_student = :id";
            
            try {
                $stmt = $db->prepare($sql);
                $stmt->execute([':email' => $email_nou, ':id' => $id_student]);
                $message = "Email actualizat cu succes prin View!";
            } catch (Exception $e) {
                $error = "Eroare la update: " . $e->getMessage();
            }
        }
    }

    // 1. INTEROGARE VIEW COMPUS (Studenti + Specializare)
    try {
        $stmt = $db->query("SELECT * FROM V_Studenti_Info ORDER BY id_student");
        $view_lmd_data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
        $error = "Nu pot citi V_Studenti_Info: " . $e->getMessage();
        $view_lmd_data = [];
    }

    // 2. INTEROGARE VIEW COMPLEX (Statistici)
    try {
        $stmt = $db->query("SELECT * FROM V_Statistici_Edituri");
        $view_complex_data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (Exception $e) {
        if (!$error) $error = "Nu pot citi V_Statistici_Edituri: " . $e->getMessage();
        $view_complex_data = [];
    }

} catch (Exception $e) {
    $error = "Eroare conexiune: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Vizualizari (Simple)</title>
</head>
<body>
    
    <a href="index.php">Inapoi la Meniu</a>
    <hr>

    <h1>Vizualizari Baza de Date (Oracle Views)</h1>

    <?php if ($message): ?> 
        <p style="color: green;"><strong><?php echo $message; ?></strong></p> 
    <?php endif; ?>
    
    <?php if ($error): ?> 
        <p style="color: red;"><strong><?php echo $error; ?></strong></p> 
    <?php endif; ?>


    <h3>1. View Compus: Studenti & Specializari (Updatable)</h3>
    <p>Poti modifica email-ul direct in tabelul de mai jos.</p>

    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr>
                <th>Student</th>
                <th>Nr. Matricol</th>
                <th>Specializare</th>
                <th>Email (Modificabil)</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($view_lmd_data)): ?>
                <tr><td colspan="4">Nu exista date in view.</td></tr>
            <?php else: ?>
                <?php foreach ($view_lmd_data as $row): ?>
                <tr>
                    <td><?php echo htmlspecialchars($row['NUME'] . ' ' . $row['PRENUME']); ?></td>
                    <td><?php echo htmlspecialchars($row['NR_MATRICOL']); ?></td>
                    <td><?php echo htmlspecialchars($row['NUME_SPECIALIZARE']); ?></td>
                    <td>
                        <form method="post">
                            <input type="hidden" name="id_student" value="<?php echo $row['ID_STUDENT']; ?>">
                            <input type="hidden" name="update_email" value="1">
                            
                            <input type="email" name="email_nou" value="<?php echo htmlspecialchars($row['EMAIL']); ?>" required>
                            <button type="submit">Salveaza</button>
                        </form>
                    </td>
                </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>

    <br><br>

    <h3>2. View Complex: Statistici Edituri (Read-Only)</h3>
    <p>Acesta contine date agregate (GROUP BY) si nu poate fi modificat.</p>

    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr>
                <th>Editura</th>
                <th>Tara</th>
                <th>Titluri Unice</th>
                <th>Exemplare Fizice (Total)</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($view_complex_data)): ?>
                <tr><td colspan="4">Nu exista date in view.</td></tr>
            <?php else: ?>
                <?php foreach ($view_complex_data as $row): ?>
                <tr>
                    <td><?php echo htmlspecialchars($row['EDITURA']); ?></td>
                    <td><?php echo htmlspecialchars($row['TARA']); ?></td>
                    <td align="center"><?php echo $row['NR_TITLURI_UNICE']; ?></td>
                    <td align="center"><?php echo $row['TOTAL_EXEMPLARE_FIZICE']; ?></td>
                </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>

</body>
</html>