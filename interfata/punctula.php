<?php
include 'db.php';

try {
    $db = getDbConnection();
} catch (Exception $e) {
    die("Eroare: " . $e->getMessage());
}

$tables = ['FACULTATE', 'SPECIALIZARE', 'STUDENT', 'EDITURA', 'DOMENIU', 'AUTOR', 'CARTE', 'SALA', 'EXEMPLAR', 'IMPRUMUT', 'AUTOR_CARTE'];

if (isset($_GET['get_columns'])) {
    $table = $_GET['get_columns'];
    if (in_array($table, $tables)) {
        $stmt = $db->query("SELECT * FROM $table WHERE 1=0");
        $cols = [];
        for ($i = 0; $i < $stmt->columnCount(); $i++) {
            $meta = $stmt->getColumnMeta($i);
            $cols[] = $meta['name'];
        }
        echo json_encode(['columns' => $cols]);
    }
    exit;
}

$selected_table = $_GET['tabel'] ?? '';
$columns = [];
$rows = [];

if ($selected_table && in_array($selected_table, $tables)) {
    $stmt_cols = $db->query("SELECT * FROM $selected_table WHERE 1=0");
    for ($i = 0; $i < $stmt_cols->columnCount(); $i++) {
        $meta = $stmt_cols->getColumnMeta($i);
        $columns[] = $meta['name'];
    }

    $sql = "SELECT * FROM $selected_table";

    if (isset($_GET['sortare']) && !empty($_GET['sortare'])) {
        $sort_col = $_GET['sortare'];
        $direction = $_GET['directie'] ?? 'ASC';
        
        if (!in_array($direction, ['ASC', 'DESC'])) {
            $direction = 'ASC';
        }

        if (in_array($sort_col, $columns)) {
            $sql .= " ORDER BY " . $sort_col . " " . $direction;
        }
    }

    $stmt = $db->query($sql);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Gestiune Biblioteca</title>
    <script>
        async function updateCols() {
            const table = document.getElementById('tabel').value;
            const res = await fetch(`?get_columns=${table}`);
            const data = await res.json();
            const select = document.getElementById('sort');
            select.innerHTML = '<option value="">Alege coloana...</option>';
            data.columns.forEach(c => {
                select.innerHTML += `<option value="${c}">${c}</option>`;
            });
        }
    </script>
</head>
<body>

    <form method="get">
        Tabel: 
        <select name="tabel" id="tabel" onchange="updateCols()">
            <option value="">Alege...</option>
            <?php foreach ($tables as $t): ?>
                <option value="<?= $t ?>" <?= $t==$selected_table?'selected':'' ?>><?= $t ?></option>
            <?php endforeach; ?>
        </select>

        Sortează după:
        <select name="sortare" id="sort">
            <option value="">Alege coloana...</option>
            <?php 
            if (!empty($columns)) {
                foreach ($columns as $c) {
                    $selected = (isset($_GET['sortare']) && $_GET['sortare'] == $c) ? 'selected' : '';
                    echo "<option value='$c' $selected>$c</option>";
                }
            }
            ?>
        </select>

        Direcție:
        <select name="directie">
            <option value="ASC" <?= (isset($_GET['directie']) && $_GET['directie'] == 'ASC') ? 'selected' : '' ?>>Ascendent</option>
            <option value="DESC" <?= (isset($_GET['directie']) && $_GET['directie'] == 'DESC') ? 'selected' : '' ?>>Descendent</option>
        </select>

        <input type="submit" value="Vezi Date">
    </form>

    <hr> 
    
    <?php if ($selected_table): ?>
        <table border="1"> 
            <thead>
                <tr>
                    <?php foreach ($columns as $c): ?>
                        <th><?= $c ?></th>
                    <?php endforeach; ?>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($rows as $r): ?>
                    <tr>
                        <?php foreach ($columns as $c): ?>
                            <td><?= $r[$c] ?></td>
                        <?php endforeach; ?>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>

</body>
</html>