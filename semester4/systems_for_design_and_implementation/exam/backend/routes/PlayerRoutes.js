const express = require("express");
const router = express.Router();

module.exports = (playerController) => 
{
    router.get("/players", playerController.playerGet.bind(playerController));
    return router;
}