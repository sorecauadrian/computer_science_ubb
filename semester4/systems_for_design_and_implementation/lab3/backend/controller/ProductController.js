const ProductRepository = require("../repository/ProductRepository");

class ProductController 
{
    constructor(repository = new ProductRepository()) {this._repository = repository;}
    get repository() {return this._repository;}
    set repository(newRepository) {this._repository = newRepository;}

    async productGet(req, res) 
    {
        try 
        {
            const {page = 1, productsPerPage = 12, filter = "", sort = "", category = ""} = req.query;
            const pageNumber = parseInt(page);
            const productsPerPageNumber = parseInt(productsPerPage);

            const startIndex = (pageNumber - 1) * productsPerPageNumber;
            const endIndex = pageNumber * productsPerPage;
            
            let products = await this.repository.getFilteredProducts(filter, category);
            const totalProducts = products.length;

            if (sort === "ascending")
                products.sort((p1, p2) => {return p1.price - p2.price;});
            else if (sort === "descending")
                products.sort((p1, p2) => {return p2.price - p1.price;})
            products = products.slice(startIndex, endIndex);

            res.json(
                {
                    "products": products,
                    "totalProducts": totalProducts,
                    "currentPage": pageNumber,
                    "totalPages": Math.ceil(totalProducts / productsPerPageNumber)
                });
        }
        catch (error)
        {
            console.error('error fetching products:', error);
            res.status(500).json({error: 'internal server error'});
        }
    }
    async productAdd(req, res) 
    {
        const { title, price, image, categoryId } = req.body;
        if (!title || isNaN(price) || price < 0 || !categoryId) 
            return res.status(400).json({ error: "invalid input" });

        try 
        {
            const newProductId = await this.repository.addProduct(title, price, image, categoryId);
            const allProducts = await this.repository.getAllProducts();
            return res.status(200).json(allProducts);
        } 
        catch (error) 
        {
            console.error('error adding product:', error); 
            return res.status(500).json({ error: "error adding product" });
        }
    }

    async productDelete(req, res) 
    {
        const id = parseInt(req.params.id);
        try 
        {
            await this.repository.deleteProductById(id);
            res.json({ message: `product with id ${id} deleted successfully` });
        } 
        catch (error) 
        {
            console.error('error deleting product:', error);
            res.status(500).json({ error: 'internal server error' });
        }
    }
    async productEdit(req, res)
    {
        const id = parseInt(req.body.id);
        const title = req.body.title;
        const price = parseFloat(req.body.price);
        const image = req.body.image;
        const categoryId = parseInt(req.body.category);
        try 
        {
            const updatedRowsCount = await this.repository.updateProductById(id, title, price, image, categoryId);
            if (updatedRowsCount > 0)
                res.json({ message: `product with id ${id} updated successfully` });
            else
                res.json({ message: `product with id ${id} not found or no changes made` });
        } 
        catch (error) 
        {
            console.error(`error updating product with id ${id}:`, error);
            res.status(500).json({ error: 'internal server error' });
        }
    }
}
module.exports = ProductController;