const express = require("express");
const cors = require("cors");
const sequelize = require('./db_connection');
const app = express();

const ProductRoutes = require("./routes/ProductRoutes");
const ProductController = require("./controller/ProductController");
const CategoryRoutes = require("./routes/CategoryRoutes");
const CategoryController = require("./controller/CategoryController");

const productController = new ProductController();
const categoryController = new CategoryController();

const corsOptions = 
{
    methods: "GET,POST,PUT,DELETE",
    allowedHeaders: "Content-Type,Authorization"
}
app.use(cors(corsOptions));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.set("view engine", "ejs");

app.use("/", ProductRoutes(productController));
app.use("/", CategoryRoutes(categoryController));

sequelize.authenticate()
        .then(() => console.log('database connected...'))
        .catch(err => console.log('error: ' + err));

sequelize.sync()
        .then(() => console.log('database synced...'))
        .catch(err => console.log('error: ' + err));

app.listen(5000, () => {console.log('server started on port 5000');});
