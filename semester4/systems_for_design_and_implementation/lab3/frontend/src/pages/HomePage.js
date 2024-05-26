import { useState } from "react";
import BarChart from "../components/Chart.js";
import Products from "../components/Products.js";
import AddButton from "../components/AddButton.js";
import ProductFilter from "../components/ProductFilter.js";

function Home()
{
    const [filterText, setFilterText] = useState('');
    const [sort, setSort] = useState(''); 
    const [products, setProducts] = useState([]);
    const [selectedCategory, setSelectedCategory] = useState('');

    return (
        <div className="py-3 container-fluid" style={{backgroundColor: "#7851A9"}}>
            <ProductFilter
                filterText={filterText}
                setFilterText={setFilterText}
                sort={sort}
                setSort={setSort}
                selectedCategory={selectedCategory}
                setSelectedCategory={setSelectedCategory}
            />
            <BarChart
                products={products}
            />
            <AddButton/>
            <Products
                filterText={filterText}
                sort={sort}  
                selectedCategory={selectedCategory}
                products={products}
                setProducts={setProducts}
            />
        </div>
    );
}

export default Home;