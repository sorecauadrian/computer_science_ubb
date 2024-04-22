import { useState } from "react";
import DreamsList from './DreamsList.js';
import SearchBar from "./SearchBar.js";
import Sort from './Sort.js';
import Filter from "./Filter.js";
import BarChart from "./Chart.js";

function Home()
{
    const [filterText, setFilterText] = useState('');
    const [lucid, setLucid] = useState(0);
    const [sorting, setSorting] = useState(0);

    return (
        <div className="py-3 container-fluid w-75 bg-secondary">
            <SearchBar
                filterText={filterText}
                onFilterTextChange={setFilterText}
            />
            <Filter
                lucid={lucid}
                onLucidChange={setLucid}
            />
            <Sort
                sort={sorting}
                onSortChange={setSorting}
            />
            <BarChart/>
            <DreamsList
                filterText={filterText}
                lucid={lucid}  
                sort={sorting}  
            />
        </div>
    );
}

export default Home;