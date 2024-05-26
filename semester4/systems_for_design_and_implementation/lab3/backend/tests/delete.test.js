const request = require("supertest");
const express = require("express");
const cors = require("cors");
const app = express();

const ProductRoutes = require("../routes/ProductRoutes");
const ProductController = require("../controller/ProductController");
const MockProductRepository = require("./mockProductRepository");

const productController = new ProductController(new MockProductRepository());

app.use(
    cors({
        methods: "GET,POST,PUT,DELETE",
        allowedHeaders: "Content-Type,Authorization",
    })
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.set("view engine", "ejs");
app.use("/", ProductRoutes(productController));

describe("Product Routes - DELETE", () => 
{
    beforeEach(() => 
    {
        productController.repository = new MockProductRepository();
        productController.repository.addProduct("title1", 1, "image1.png", 1);
        productController.repository.addProduct("title2", 3, "image2.png", 1);
        productController.repository.addProduct("title3", 2, "image3.png", 1);
    });
    it("DELETE /delete/:id should respond with 200 and delete the product", async () => 
    {
        const productsBeforeDelete = await productController.repository.getAllProducts();
        const productIdToDelete = productsBeforeDelete[0].id;
        const expectedLength = productsBeforeDelete.length - 1;
        const response = await request(app).delete(`/delete/${productIdToDelete}`);
        expect(response.status).toBe(200);
        expect(response.body.message).toBe(`product with id ${productIdToDelete} deleted successfully`);
        
        const productsAfterDelete = await productController.repository.getAllProducts();
        expect(productsAfterDelete.length).toBe(expectedLength);
    });
});
