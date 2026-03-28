<?php
include 'db.php'; 
?>

<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <title>Biblioteca Universitară</title>
    <style>
        body { font-family: Times New Roman, sans-serif; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Biblioteca Universitară</h1>
    <ul>
                <li><a href="/punctula.php">Listare cu Meniu (Tabele și Sortare)</a></li>
		<li><a href="/punctulb.php">Editare/Ștergere Înregistrări</a></li>
                <li><a href="/punctulc.php">Interogare punctul c (afisarea cartilor publicate de edituri din Romania scrise de autori straini)</a></li>
                <li><a href="/punctuld.php">Lista studentilor care au imprumutat cel putin de doua ori</a></li>
                <li><a href="/punctule.php">Cerere de tip "ON DELETE CASCADE" </a></li>
                <li><a href="/punctulf.php">Creare vizualizari </a></li>

        

 
                
    </ul>
</body>
</html>