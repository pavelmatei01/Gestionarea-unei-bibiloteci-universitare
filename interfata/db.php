<?php
function getDbConnection() {
    try {
                $dsn = 'oci:dbname=//localhost:1521/XE';  // Format: //host:port/SID (XE e default pentru Oracle Express)
        $username = 'pavel';  // Ex: 'SYSTEM' sau user-ul tău din SQL Developer
        $password = 'Uzului16#';  // Parola ta

        $db = new PDO($dsn, $username, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $db;
    } catch (PDOException $e) {
        die("Eroare conexiune Oracle: " . $e->getMessage());
    }
}
?>