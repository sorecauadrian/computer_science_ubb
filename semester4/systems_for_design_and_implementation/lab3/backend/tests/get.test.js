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

describe("Product Routes - GET", () => {
    beforeEach(() => 
    {
        productController.repository = new MockProductRepository();
        productController.repository.addProduct("title1", 1, "image1.png", 1);
        productController.repository.addProduct("title2", 3, "image2.png", 1);
        productController.repository.addProduct("title3", 2, "image3.png", 1);
    });
    it("GET /products should respond with 200 and return all products", async () => 
    {
        const response = await request(app).get(`/products`);
        expect(response.status).toBe(200);
        expect(response.body.products.length).toBe(3);
        expect(response.body.totalProducts).toBe(3);
    });

    it("GET /products with filter should respond with 200 and return filtered products", async () => 
    {
        const response = await request(app).get(`/products?filter=title1`);
        expect(response.status).toBe(200);
        expect(response.body.products.length).toBe(1);
        expect(response.body.products[0].title).toBe("title1");
    });

    it("GET /products with sort ascending should respond with 200 and return sorted products", async () => 
    {
        const response = await request(app).get(`/products?sort=ascending`);
        expect(response.status).toBe(200);
        expect(response.body.products.length).toBe(3);
        expect(response.body.products[0].price).toBe(1);
        expect(response.body.products[1].price).toBe(2);
        expect(response.body.products[2].price).toBe(3);
    });

    it("GET /products with sort descending should respond with 200 and return sorted products", async () => 
    {
        const response = await request(app).get(`/products?sort=descending`);
        expect(response.status).toBe(200);
        expect(response.body.products.length).toBe(3);
        expect(response.body.products[0].price).toBe(3);
        expect(response.body.products[1].price).toBe(2);
        expect(response.body.products[2].price).toBe(1);
    });

    it("GET /products with non-existing category should respond with 200 and return empty array", async () => 
    {
        const response = await request(app).get(`/products?category=non-existing`);
        expect(response.status).toBe(200);
        expect(response.body.products.length).toBe(0);
    });
});

