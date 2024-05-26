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

describe("Product Routes - PUT", () => 
{
    beforeEach(() => 
    {
        productController.repository = new MockProductRepository();
        productController.repository.addProduct("title1", 1, "image1.png", 1);
        productController.repository.addProduct("title2", 3, "image2.png", 1);
        productController.repository.addProduct("title3", 2, "image3.png", 1);
    });
    it("PUT /edit should respond with 200 and update the product", async () => 
    {
        const productId = await productController.repository.addProduct("test", 1, "test.jpg", 1);
        const updatedProduct = {
            id: productId,
            title: "updated title",
            price: 10,
            image: "updated_image.png",
            category: 1,
        };
        const response = await request(app).put(`/edit`).send(updatedProduct);
        expect(response.status).toBe(200);

        const updatedProductFromDb = await productController.repository.getProductById(productId);
        expect(updatedProductFromDb.title).toBe(updatedProduct.title);
        expect(updatedProductFromDb.price).toBe(updatedProduct.price);
        expect(updatedProductFromDb.image).toBe(updatedProduct.image);
        expect(updatedProductFromDb.categoryId).toBe(updatedProduct.category);
    });
});
