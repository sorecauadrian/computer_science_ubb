import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { InputGroup, Form, Button } from "react-bootstrap";
import { TiEdit } from "react-icons/ti";
import { GoHome } from "react-icons/go";
import api from '../api';

function Edit()
{
    const [id, setId] = useState(0);
    const [title, setTitle] = useState("");
    const [price, setPrice] = useState(0);
    const [image, setImage] = useState("");
    const [category, setCategory] = useState(0);
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
            alert("please insert a positive price");
            return;
        }

        const payload = {id, title, price, image, category};
        console.log('payload to be sent:', payload);
        
        try
        {
            const response = await api.put('/edit', payload);
            console.log('product edited:', response.data);
            history("/");
        } 
        catch (error) 
        {
            console.error('error editing product:', error);
            console.error('error response data:', error.response ? error.response.data : 'no response data');
        }
    }

    useEffect(() => 
    {
        setId(localStorage.getItem("id"));
        setTitle(localStorage.getItem("title"));
        setPrice(localStorage.getItem("price"));
        setImage(localStorage.getItem("image"));
        setCategory(localStorage.getItem("category"));

        const fetchCategories = async () => 
        {
            try
            {
                const response = await api.get('http://localhost:5000/categories');
                setCategories(response.data);
            }
            catch (error) {console.error('error fetching categories:', error);}
        };

        fetchCategories();
    }, []);

    return (
        <div className="py-2 container-fluid w-50 bg-secondary">
            <InputGroup className="py-2">
                <InputGroup.Text id="title">title</InputGroup.Text>
                <Form.Control data-testid="title" aria-describedby="title" value={title} onChange={(e) => setTitle(e.target.value)}/>
            </InputGroup>
            <InputGroup className="py-2">
                <InputGroup.Text id="price">price</InputGroup.Text>
                <Form.Control data-testid="price" aria-describedby="price" value={price} onChange={(e) => setPrice(e.target.value)}/>
            </InputGroup>
            <InputGroup className="py-2">
                <InputGroup.Text id="image">image</InputGroup.Text>
                <Form.Control data-testid="image" aria-describedby="image" value={image} onChange={(e) => setImage(e.target.value)}/>
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
                    {/*<option value="">select category</option>*/}
                    {categories.map((cat) => (
                        <option key={cat.id} value={cat.id}>
                            {cat.name}
                        </option>
                    ))}
                </Form.Control>
            </InputGroup>
            <div className="d-grid py-2">
                <Button data-testid="edit" variant="warning" type="submit" onClick={(e) => handleSubmit(e)}><TiEdit /></Button>
                <Button variant="dark" onClick={() => {history('/');}}><GoHome /></Button>
            </div>
        </div>
    );
}

export default Edit;