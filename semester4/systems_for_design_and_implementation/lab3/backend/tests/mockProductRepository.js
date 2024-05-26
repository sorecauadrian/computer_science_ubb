const Product = require("../model/Product");

class MockProductRepository 
{
    constructor() {
        this.products = [];
        this.categories = [
            { id: 1, name: 'test' },
        ];
        this.nextId = 1;
    }

    async addProduct(title, price, image, categoryId) 
    {
        const newProduct = { id: this.nextId++, title, price, image, categoryId };
        this.products.push(newProduct);
        return newProduct.id;
    }

    async getAllProducts() {return this.products;}

    async getFilteredProducts(filter = "", category = "") 
    {
        let filteredProducts = this.products;

        if (filter)
            filteredProducts = filteredProducts.filter(product =>
                product.title.toLowerCase().includes(filter.toLowerCase())
            );

        if (category) {
            const categoryObj = this.categories.find(cat => cat.name === category);
            if (!categoryObj) return [];
            filteredProducts = filteredProducts.filter(product => product.categoryId === categoryObj.id);
        }

        return filteredProducts;
    }

    async updateProductById(id, newTitle, newPrice, newImage, newCategoryId) 
    {
        const productIndex = this.products.findIndex(product => product.id === id);
        if (productIndex === -1) return 0;

        this.products[productIndex] = {
            id,
            title: newTitle,
            price: newPrice,
            image: newImage,
            categoryId: newCategoryId
        };

        return 1;
    }

    async deleteProductById(id) 
    {
        const productIndex = this.products.findIndex(product => product.id === id);
        if (productIndex === -1) return;

        this.products.splice(productIndex, 1);
    }

    async getProductById(id) {
        const products = this.products.filter(product => product.id === id);
        if (products.length === 0) {
            throw new Error(`Product with ID ${id} not found`);
        }
        return products[0];
    }
}

module.exports = MockProductRepository;
