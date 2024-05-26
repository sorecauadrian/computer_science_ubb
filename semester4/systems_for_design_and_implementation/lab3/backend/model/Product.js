/*
class Product 
{
    constructor(id, title, price, image)
    {
        this._id = id;
        this._title = title;
        this._price = price;
        this._image = image;
    }

    get id() {return this._id;}
    get title() {return this._title;}
    get price() {return this._price;}
    get image() {return this._image;}

    set id(newId) {this._id = newId;}
    set title(newTitle) {this._title = newTitle;}
    set price(newPrice) {this._price = newPrice;}
    set image(newImage) {this._image = newImage;}
}

module.exports = Product;
*/

const { DataTypes } = require('sequelize');
const sequelize = require('../db_connection');
const Category = require('./Category');

const Product = sequelize.define('Product', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    title: {
        type: DataTypes.STRING,
        allowNull: false
    },
    price: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    image: {
        type: DataTypes.STRING,
        allowNull: true
    },
    categoryId: {
        type: DataTypes.INTEGER,
        references: {
            model: Category,
            key: 'id'
        },
        allowNull: true
    }
}, {
    tableName: 'product',
    timestamps: false
});
Category.hasMany(Product, {foreignKey: 'categoryId'});
Product.belongsTo(Category, {foreignKey: 'categoryId'});

module.exports = Product;