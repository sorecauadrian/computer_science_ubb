import { useState } from "react";
import Players from "../components/Players.js";
import Sort from '../components/Sort';

function Home()
{
    const [players, setPlayers] = useState([]);
    const [sortShirt, setSortShirt] = useState(''); 
    const [sortName, setSortName] = useState('');

    return (
        <div className="py-3 container-fluid" style={{backgroundColor: "#7851A9"}}>
            <Players
                players={players}
                setPlayers={setPlayers}
                sortShirt={sortShirt}
                sortName={sortName}
            />
            <Sort sortShirt={sortShirt} onSortShirtChange={setSortShirt} sortName={sortName} onSortNameChange={setSortName}/>
        </div>
    );
}

export default Home;