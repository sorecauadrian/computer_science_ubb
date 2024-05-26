import Product from './Product.js';
import { CardGroup } from 'react-bootstrap';
import { useState, useEffect } from 'react';
import PaginationFooter from './PaginationFooter.js';
import api from '../api';

function Products({filterText, sort, selectedCategory, products, setProducts}) 
{
    const [page, setPage] = useState(1);
    const [productsPerPage, setProductsPerPage] = useState(12);
    const [totalProducts, setTotalProducts] = useState(0);
    const [totalPages, setTotalPages] = useState(0);

    const handleDelete = async (id) =>
    {
        try
        {
            const response = await api.delete(`http://localhost:5000/delete/${id}`);
            setProducts(products.filter(product => product.id !== id)); // just a fix for the moment
            setTotalProducts(totalProducts - 1);
            console.log('product deleted:', response.data);
        } 
        catch (error) {console.error(`error deleting the product with id ${id}:`, error);}
    }

    useEffect(() => 
    {
        const fetchProducts = async () => 
        {
            try 
            {
                const response = await api.get(`/products?page=${page}&productsPerPage=${productsPerPage}&filter=${filterText}&sort=${sort}&category=${selectedCategory}`);
                setProducts(response.data.products);
                setTotalProducts(response.data.totalProducts);
                setPage(response.data.currentPage);
                setTotalPages(response.data.totalPages);
            } 
            catch (error) {console.error('error fetching products: ', error);}
        };
    
        fetchProducts();
    }, [setProducts, page, productsPerPage, filterText, sort, selectedCategory]);

    const handleChangeProductsPerPage = (e) => 
    {
        setProductsPerPage(parseInt(e.target.value));
        setPage(1);
    };

    function handleEdit(id, title, price, image, category)
    {
        // storing them in the localStorage hook so we will access them on the edit page.
        localStorage.setItem("id", id);
        localStorage.setItem("title", title);
        localStorage.setItem("price", price);
        localStorage.setItem("image", image);
        localStorage.setItem("category", category);
    }
    return (
        <>  
            <CardGroup className='d-flex flex-wrap'>
                {products.map((product) => {return (<Product data-testid='product' product={product} key={product.id} handleDelete={handleDelete} handleEdit={handleEdit}/>);})}
            </CardGroup>
            <PaginationFooter currentPage={page} onPageChange={setPage} totalPages={totalPages} productsPerPage={productsPerPage} handleChangeProductsPerPage={handleChangeProductsPerPage} totalProducts={totalProducts}/>
        </>
    );
}

export default Products;