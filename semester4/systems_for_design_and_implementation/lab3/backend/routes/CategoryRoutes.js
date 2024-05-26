const express = require('express');
const router = express.Router();

module.exports = (categoryController) => 
{
    router.post("/addCategory", categoryController.categoryAdd.bind(categoryController));
    router.put("/editCategory", categoryController.categoryEdit.bind(categoryController));
    router.delete("/deleteCategory/:id", categoryController.categoryDelete.bind(categoryController));
    router.get("/categories", categoryController.categoryGet.bind(categoryController));
    return router;
}