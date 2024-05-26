const express = require("express");
const router = express.Router();

module.exports = (productController) => 
{
    router.post("/add", productController.productAdd.bind(productController));
    router.put("/edit", productController.productEdit.bind(productController));
    router.delete("/delete/:id", productController.productDelete.bind(productController));
    router.get("/products", productController.productGet.bind(productController));
    return router;
}