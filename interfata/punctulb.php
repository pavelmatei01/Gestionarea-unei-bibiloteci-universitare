<?php
// edit_delete_simplu.php
include 'db.php'; 
$db = getDbConnection();

// 1. Obținem lista de tabele din Oracle
$stmt = $db->query("SELECT table_name FROM user_tables ORDER BY table_name");
$tables = $stmt->fetchAll(PDO::FETCH_COLUMN);

$selected_table = $_GET['tabel'] ?? '';
$action = $_GET['action'] ?? '';
$id = $_GET['id'] ?? '';
$save_action = $_POST['action'] ?? '';

$columns = [];
$rows = [];
$edit_data = [];

if ($selected_table && in_array($selected_table, $tables)) {
    // Aflăm coloanele
    $stmt = $db->query("SELECT * FROM \"$selected_table\" WHERE 1=0");
    for ($i = 0; $i < $stmt->columnCount(); $i++) {
        $meta = $stmt->getColumnMeta($i);
        $columns[] = $meta['name'];
    }
    $pk = $columns[0]; // Prima coloană e cheia primară

    // --- LOGICĂ ȘTERGERE ---
    if ($action == 'delete' && $id) {
        $stmt = $db->prepare("DELETE FROM \"$selected_table\" WHERE \"$pk\" = ?");
        $stmt->execute([$id]);
        header("Location: ?tabel=$selected_table");
        exit;
    }

    // --- LOGICĂ SALVARE EDITARE ---
    if ($save_action == 'save_edit' && $id) {
        $updates = []; $values = [];
        foreach ($columns as $col) {
            if ($col != $pk) {
                $updates[] = "\"$col\" = ?";
                $values[] = $_POST[$col] ?? '';
            }
        }
        $values[] = $id;
        $sql = "UPDATE \"$selected_table\" SET " . implode(', ', $updates) . " WHERE \"$pk\" = ?";
        $db->prepare($sql)->execute($values);
        header("Location: ?tabel=$selected_table");
        exit;
    }

    // --- DATE PENTRU FORMULARUL DE EDITARE ---
    if ($action == 'edit' && $id) {
        $stmt = $db->prepare("SELECT * FROM \"$selected_table\" WHERE \"$pk\" = ?");
        $stmt->execute([$id]);
        $edit_data = $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // --- DATE PENTRU TABEL ---
    $rows = $db->query("SELECT * FROM \"$selected_table\"")->fetchAll(PDO::FETCH_ASSOC);
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Simpu</title>
</head>
<body>
    <h2>Gestiune Date</h2>

    <form method="get">
        Tabel: 
        <select name="tabel">
            <option value="">Alege...</option>
            <?php foreach ($tables as $t): ?>
                <option value="<?= $t ?>" <?= $t==$selected_table?'selected':'' ?>><?= $t ?></option>
            <?php endforeach; ?>
        </select>
        <input type="submit" value="Deschide">
    </form>

    <hr>

    <?php if ($action == 'edit' && $edit_data): ?>
        <div style="background: #eee; padding: 10px;">
            <h3>Editare rând ID: <?= $id ?></h3>
            <form method="post">
                <input type="hidden" name="action" value="save_edit">
                <?php foreach ($columns as $col): if ($col != $pk): ?>
                    <label><?= $col ?>:</label><br>
                    <input type="text" name="<?= $col ?>" value="<?= htmlspecialchars($edit_data[$col]) ?>"><br>
                <?php endif; endforeach; ?>
                <br>
                <input type="submit" value="Salvează">
                <a href="?tabel=<?= $selected_table ?>">Anulează</a>
            </form>
        </div>
        <hr>
    <?php endif; ?>

    <?php if ($selected_table): ?>
        <table border="1">
            <tr>
                <?php foreach ($columns as $col): ?>
                    <th><?= $col ?></th>
                <?php endforeach; ?>
                <th>Acțiuni</th>
            </tr>
            <?php foreach ($rows as $row): ?>
                <tr>
                    <?php foreach ($columns as $col): ?>
                        <td><?= htmlspecialchars($row[$col]) ?></td>
                    <?php endforeach; ?>
                    <td>
                        <a href="?tabel=<?= $selected_table ?>&action=edit&id=<?= $row[$pk] ?>">Edit</a> | 
                        <a href="?tabel=<?= $selected_table ?>&action=delete&id=<?= $row[$pk] ?>" onclick="return confirm('Ștergi?')">Șterge</a>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    <?php endif; ?>

</body>
</html>