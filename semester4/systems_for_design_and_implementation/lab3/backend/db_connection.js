const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('human_wearing', 'root', '', {
    host: 'localhost',
    dialect: 'mysql'
});

module.exports = sequelize;

/*
const mysql = require("mysql");
const db_connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "human_wearing"
});

db_connection.connect((err) => {
    if (err) {
        console.error('error connecting to mysql database:', err);
        return;
    }
    console.log('connected to mysql database');
});

module.exports = db_connection;
*/
