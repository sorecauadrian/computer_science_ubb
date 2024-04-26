<?php
    require_once 'config.php';
    require_once 'functions.php';

    // starting session if not already started
    session_start();
?>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document Management System</title>
    </head>
    <body>
    <?php
        include_once 'templates/header.php';

        // Routing logic based on URL parameters or request method
        if ($_SERVER['REQUEST_METHOD'] === 'GET') 
        {
            echo 'get';
            // handling get requests
            if ($_GET['page'] === 'browse')
                include_once 'pages/browse_documents.php';
            elseif ($_GET['page'] === 'add')
                include_once 'pages/add_document.php';
            elseif ($_GET['page'] === 'edit')
                include_once 'pages/edit_document.php';
            elseif ($_GET['page'] === 'delete')
                include_once 'pages/delete_document.php';
            else
                // Default page or error handling
                include_once 'pages/browse_documents.php';
        } 
        elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // Handle POST requests
            // Add logic for form submissions
            // Example:
            // if ($_POST['action'] === 'add_document') {
            //     add_document($_POST['data']);
            // }
        }

        include_once 'templates/footer.php';
    ?>
    </body>
</html>
