// repository/ProductRepository.js
const { Sequelize, Op, where } = require("sequelize");
const db_connection = require("../db_connection");
const Product = require("../model/Product");
const Category = require("../model/Category");

class ProductRepository 
{
    async addProduct(title, price, image, categoryId) 
    {
        const product = await Product.create({ title, price, image, categoryId });
        return product.id;
    }

    async updateProductById(id, newTitle, newPrice, newImage, newCategoryId) 
    {
        const [updatedRowsCount] = await Product.update(
            { title: newTitle, price: newPrice, image: newImage, categoryId: newCategoryId }, 
            { where: { id } }
        );
        return updatedRowsCount;
    }

    async deleteProductById(id) {await Product.destroy({ where: { id } });}

    async getFilteredProducts(filter, categoryName) 
    {
        const whereClause = {};

        if (filter)
            whereClause.title = { [Sequelize.Op.like]: `%${filter}%` };

        if (categoryName)
        {
            const category = await Category.findOne({where: {name: categoryName}});
            if (!category)
                throw new Error(`category with name ${categoryName} not found`);
            whereClause.categoryId = category.id;
        }
        return await Product.findAll({ 
            where: whereClause, 
            include: [{model: Category, attributes: ['name']}],
            attributes: ['id', 'title', 'price', 'image', 'categoryId']
        });
    }
    async getAllProducts() 
    {
        return await Product.findAll({
            include: [{ model: Category, attributes: ['name'] }],
            attributes: ['id', 'title', 'price', 'image', 'categoryId']
        });
    }
}

module.exports = ProductRepository;
