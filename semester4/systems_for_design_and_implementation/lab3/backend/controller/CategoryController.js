const CategoryRepository = require("../repository/CategoryRepository");

class CategoryController 
{
    constructor() {this._repository = new CategoryRepository();}

    get repository() {return this._repository;}

    set repository(newRepository) {this._repository = newRepository;}

    async categoryGet(req, res) 
    {
        try 
        {
            const categories = await this.repository.getAllCategories();
            res.json(categories);
        } 
        catch (error) 
        {
            console.error('error fetching categories:', error);
            res.status(500).json({ error: 'internal server error' });
        }
    }

    async categoryAdd(req, res) 
    {
        const name = req.body.name;
        try 
        {
            const categoryId = await this.repository.addCategory(name);
            res.json({ message: `category with id ${categoryId} added successfully` });
        } 
        catch (error) 
        {
            console.error('error adding category:', error);
            res.status(500).json({ error: "internal server error" });
        }
    }

    async categoryDelete(req, res) 
    {
        const id = parseInt(req.params.id);
        try 
        {
            await this.repository.deleteCategoryById(id);
            res.json({ message: `category with id ${id} deleted successfully` });
        } 
        catch (error) 
        {
            console.error('error deleting category:', error);
            res.status(500).json({ error: 'internal server error' });
        }
    }

    async categoryEdit(req, res) 
    {
        const id = parseInt(req.body.id);
        const name = req.body.name;
        try 
        {
            const updatedRowsCount = await this.repository.updateCategoryById(id, name);
            if (updatedRowsCount > 0)
                res.json({ message: `category with id ${id} updated successfully` });
            else
                res.json({ message: `category with id ${id} not found or no changes made` });
        } 
        catch (error) 
        {
            console.error(`error updating category with id ${id}:`, error);
            res.status(500).json({ error: 'internal server error' });
        }
    }
}

module.exports = CategoryController;
