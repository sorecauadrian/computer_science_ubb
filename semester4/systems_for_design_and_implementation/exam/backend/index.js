const express = require("express");
const cors = require("cors");
const sequelize = require('./db_connection');
const app = express();

const PlayerRoutes = require("./routes/PlayerRoutes");
const PlayerController = require("./controller/PlayerController");

const playerController = new PlayerController();

const corsOptions = {
    methods: "GET",
    allowedHeaders: "Content-Type,Authorization"
};

app.use(cors(corsOptions));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.set("view engine", "ejs");

app.use("/", PlayerRoutes(playerController));

sequelize.authenticate()
        .then(() => console.log('database connected...'))
        .catch(err => console.log('error: ' + err));

sequelize.sync()
        .then(() => console.log('database synced...'))
        .catch(err => console.log('error: ' + err));

app.listen(5000, () => {
    console.log('server started on port 5000');
});
