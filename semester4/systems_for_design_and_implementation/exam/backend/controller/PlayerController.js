const PlayerRepository = require("../repository/PlayerRepository");

class PlayerController 
{
    constructor(repository = new PlayerRepository()) {this._repository = repository;}
    get repository() {return this._repository;}
    set repository(newRepository) {this._repository = newRepository;}

    async playerGet(req, res) 
    {
        try 
        {
            const {sortShirt = "", sortName = ""} = req.query;
            let players = await this.repository.getAll();
            if (sortShirt === "ascending")
                players.sort((p1, p2) => {return p1.shirt_no - p2.shirt_no;});
            else if (sortShirt === "descending")
                players.sort((p1, p2) => {return p2.shirt_no - p1.shirt_no;});

            const PlayerRepository = require("../repository/PlayerRepository");

class PlayerController 
{
    constructor(repository = new PlayerRepository()) {this._repository = repository;}
    get repository() {return this._repository;}
    set repository(newRepository) {this._repository = newRepository;}

    async playerGet(req, res) 
    {
        try 
        {
            const {sortShirt = "", sortName = ""} = req.query;
            let players = await this.repository.getAll();
            if (sortShirt === "ascending")
                players.sort((p1, p2) => {return p1.shirt_no - p2.shirt_no;});
            else if (sortShirt === "descending")
                players.sort((p1, p2) => {return p2.shirt_no - p1.shirt_no;});

            if (sortName === "ascending") {
                players.sort((p1, p2) => p1.name.localeCompare(p2.name));
            } else if (sortName === "descending") {
                players.sort((p1, p2) => p2.name.localeCompare(p1.name));
            }
            res.json(
                {
                    "players": players
                });
        }
        catch (error)
        {
            console.error('error fetching products:', error);
            res.status(500).json({error: 'internal server error'});
        }
    }
}
module.exports = PlayerController;
            res.json(
                {
                    "players": players
                });
        }
        catch (error)
        {
            console.error('error fetching products:', error);
            res.status(500).json({error: 'internal server error'});
        }
    }
}
module.exports = PlayerController;