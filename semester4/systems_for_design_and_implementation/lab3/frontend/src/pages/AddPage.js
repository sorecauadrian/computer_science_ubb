import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { InputGroup, Form, Button } from "react-bootstrap";
import { GrAdd } from "react-icons/gr";
import { GoHome } from "react-icons/go";
import api from '../api';

function Add()
{
    const [title, setTitle] = useState("");
    const [price, setPrice] = useState(0);
    const [image, setImage] = useState("");
    const [category, setCategory] = useState("");
    const [categories, setCategories] = useState([]);
    
    let history = useNavigate();
    
    const handleSubmit = async (e) => 
    {
        e.preventDefault();
        
        if (title === "")
        {
            alert("please insert a title.");
            return;
        }
        else if (isNaN(price))
        {
            alert("please insert a numerical price.");
            return;
        }
        else if (price < 0)
        {
            alert("please insert a positive price.");
            return;
        }

        try
        {

            const categoryId = Number(category);
            if (isNaN(categoryId)) {
                alert("please select a valid category.");
                return;
            }

            console.log(`submitting with category ID: ${categoryId}`);

            const response = await api.post('http://localhost:5000/add', {"title": title, "price": price, "image": image, "categoryId": categoryId});
            console.log('product added:', response.data);
            history("/");
        } 
        catch (error) {console.error('error adding product:', error);}
    };

    useEffect(() => 
    {
        const fetchCategories = async () => 
        {
            try 
            {
                const response = await api.get('http://localhost:5000/categories');
                setCategories(response.data);
                if (response.data.length > 0)
                    setCategory(response.data[0].id.toString());
            } 
            catch (error) {console.error('error fetching categories:', error);}
        };

        fetchCategories();
    }, []);
    
    return (
        <div className="py-2 container-fluid w-50 bg-secondary">
            <InputGroup className="py-2">
                <InputGroup.Text id="title">title</InputGroup.Text>
                <Form.Control data-testid="title" aria-describedby="title" onChange={(e) => setTitle(e.target.value)} required/>
            </InputGroup>
            <InputGroup className="py-2">
                <InputGroup.Text id="price">price</InputGroup.Text>
                <Form.Control data-testid="price" aria-describedby="price" onChange={(e) => setPrice(Number(e.target.value))} required/>
            </InputGroup>
            <InputGroup className="py-2">
                <InputGroup.Text id="image">image</InputGroup.Text>
                <Form.Control data-testid="image" aria-describedby="image" onChange={(e) => setImage(e.target.value)} required/>
            </InputGroup>
            <InputGroup className="py-2">
                <InputGroup.Text id="category">category</InputGroup.Text>
                <Form.Control
                    as="select"
                    data-testid="category"
                    aria-describedby="category"
                    value={category}
                    onChange={(e) => setCategory(e.target.value)}
                >
                    {categories.map((cat) => (
                        <option key={cat.id} value={cat.id.toString()}>
                            {cat.name}
                        </option>
                    ))}
                </Form.Control>
            </InputGroup>
            <div className="d-grid py-2">
                <Button data-testid="add" variant="success" type="submit" onClick={(e) => handleSubmit(e)}><GrAdd /></Button>
                <Button variant="dark" onClick={() => {history("/");}}><GoHome /></Button>
            </div>
        </div>
    );
}

export default Add;