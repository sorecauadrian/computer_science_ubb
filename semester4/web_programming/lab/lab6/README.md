# lab6 - php, ajax, json

In this lab you will have to develop a server-side web application in PHP. The web application has to manipulate a Mysql database with 1 to 3 tables and should implement the following base operations on these tables: select, insert, delete, update. Also the web application must use AJAX for getting data asynchronously from the web server and the web application should contain at least 5 web pages (client-side html or server-side php).

For the database, you can use the mysql database on www.scs.ubbcluj.ro. On this myql server you have an account, a password and a database, all identical to your username and password on the SCS network.

Please make sure that you avoid sql-injection attacks when working with the database.

Have in mind the user experience when you implement the problem:

- add different validation logic for input fields
- do not force the user to input an ID for an item if he wants to delete/edit/insert it; this should happen automatically (e.g. the user clicks an item from a list, and a page/modal prepopulated with the data for that particular item is opened, where the user can edit it)
- add confirmation when the user deletes/cancels an item
- do a bare minimum CSS that at least aligns the various input fields

Write a web application for managing documents. The application should maintain various information about a document in the database (i.e. author, title, number of pages, type, format etc.). The application should implement: document browsing (use AJAX for retrieving documents of a specific type or format), adding, removing and updating a document. Also, on the browsing page, the filter used for the previous browsing action (i.e. type or format), should be displayed (do this in javascript).