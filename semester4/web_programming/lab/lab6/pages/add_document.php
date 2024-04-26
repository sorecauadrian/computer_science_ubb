<?php
    require_once '../config.php';
    require_once '../functions.php';

    // checking if form is submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST") 
    {
        $title = $_POST['title'];
        $author = $_POST['author'];
        $pages = $_POST['pages'];
        $type = $_POST['type'];
        $format = $_POST['format'];

        $sql = "INSERT INTO document (title, author, pages, type, format) VALUES ('$title', '$author', '$pages', '$type', '$format')";
        
        if (mysqli_query($conn, $sql))
            echo "Document added successfully";
        else
            echo "Error: " . $sql . "<br>" . mysqli_error($conn);
    }

    mysqli_close($conn);
?>
