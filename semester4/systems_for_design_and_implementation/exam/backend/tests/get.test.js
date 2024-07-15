const request = require("supertest");
const express = require("express");
const cors = require("cors");
const app = express();

const PlayerRoutes = require("../routes/PlayerRoutes");
const PlayerController = require("../controller/PlayerController");

const playerController = new PlayerController();

app.use(
    cors({
        methods: "GET",
        allowedHeaders: "Content-Type,Authorization",
    })
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.set("view engine", "ejs");
app.use("/", PlayerRoutes(playerController));

describe("Player Routes - GET", () => {
    it("GET /players should respond with 200 and return all players", async () => 
    {
        const response = await request(app).get(`/players`);
        expect(response.status).toBe(200);
        expect(response.body.players.length).toBe(0);
    });
});

