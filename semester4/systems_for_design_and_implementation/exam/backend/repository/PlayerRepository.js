const { Sequelize, Op } = require("sequelize");
const db_connection = require("../db_connection");
const Player = require("../model/Player");

class PlayerRepository 
{
    async getAll() 
    {
        return await Player.findAll({
            attributes: ['id', 'name', 'shirt_no', 'height', 'weight', 'photo', 'position', 'isTitular', 'description', 'team_id']
        });
    }
}

module.exports = PlayerRepository;
