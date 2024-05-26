const { Sequelize, Op } = require("sequelize");
const db_connection = require("../db_connection");
const Category = require("../model/Category");

class CategoryRepository 
{
    async addCategory(name) 
    {
        const category = await Category.create({ name });
        return category.id;
    }

    async updateCategoryById(id, newName) 
    {
        const [updatedRowsCount] = await Category.update(
            { name: newName },
            { where: { id } }
        );
        return updatedRowsCount;
    }

    async deleteCategoryById(id) {await Category.destroy({ where: { id } });}

    async getAllCategories() {return await Category.findAll({ attributes: ['id', 'name'] });}
}

module.exports = CategoryRepository;
