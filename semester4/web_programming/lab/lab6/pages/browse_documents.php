<?php
    require_once '../config.php';
    require_once '../functions.php';

    $sql = "SELECT * FROM document";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) 
        while ($row = mysqli_fetch_assoc($result))
            echo "<p>Title: " . $row["title"] . " - Author: " . $row["author"] . "</p>";
    else
        echo "No documents found";

    mysqli_close($conn);
?>
