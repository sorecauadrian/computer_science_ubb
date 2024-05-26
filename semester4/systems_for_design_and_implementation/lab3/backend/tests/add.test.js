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

describe("Product Routes - POST", () => {
    beforeEach(() => 
    {
        productController.repository = new MockProductRepository();
        productController.repository.addProduct("title1", 1, "image1.png", 1);
        productController.repository.addProduct("title2", 3, "image2.png", 1);
        productController.repository.addProduct("title3", 2, "image3.png", 1);
    });
    it("POST /add should respond with 200 and add a new product", async () => {
        const newProduct = {
            title: "title4",
            price: 1.5,
            image: "image4.png",
            categoryId: 1,
        };
        const response = await request(app).post(`/add`).send(newProduct);
        expect(response.status).toBe(200);
        expect(response.body.length).toBe(4);
    });

    it("POST /add should respond with 500 for missing title", async () => {
        const newProduct = {
            price: 1.5,
            image: "image4.png",
            categoryId: 1,
        };
        const response = await request(app).post(`/add`).send(newProduct);
        expect(response.status).toBe(400);
        expect(response.body.error).toBe("invalid input");
    });
    
    it("POST /add should respond with 500 for missing categoryId", async () => {
        const newProduct = {
            title: "title7",
            price: 1.5,
            image: "image7.png",
        };
        const response = await request(app).post(`/add`).send(newProduct);
        expect(response.status).toBe(400);
        expect(response.body.error).toBe("invalid input");
    });
});
