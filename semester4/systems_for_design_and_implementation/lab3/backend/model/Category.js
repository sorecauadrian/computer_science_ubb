const { DataTypes } = require('sequelize');
const sequelize = require('../db_connection');

const Category = sequelize.define('Category', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    name: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
    }
}, {
    tableName: 'category',
    timestamps: false
});

module.exports = Category;