<?php
    $db_host = 'localhost';
    $db_username = 'root';
    $db_password = '';
    $db_name = 'lab6';

    // establishing the database connection
    $conn = mysqli_connect($db_host, $db_username, $db_password, $db_name);

    // checking the connection
    if (!$conn)
        die("Connection failed: " . mysqli_connect_error());
?>
