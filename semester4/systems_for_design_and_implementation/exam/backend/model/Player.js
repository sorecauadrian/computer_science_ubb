const { DataTypes } = require('sequelize');
const sequelize = require('../db_connection');

const Player = sequelize.define('Player', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    name: {
        type: DataTypes.STRING,
        allowNull: false
    },
    shirt_no: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    height: {
        type: DataTypes.FLOAT,
        allowNull: false
    },
    weight: {
        type: DataTypes.FLOAT,
        allowNull: false
    },
    position: {
        type: DataTypes.STRING,
        allowNull: false
    },
    isTitular: {
        type: DataTypes.BOOLEAN,
        allowNull: false
    },
    description: {
        type: DataTypes.STRING,
        allowNull: true
    },
    photo: {
        type: DataTypes.STRING,
        allowNull: true
    },
    team_id: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
}, {
    tableName: 'player',
    timestamps: false
});

module.exports = Player;