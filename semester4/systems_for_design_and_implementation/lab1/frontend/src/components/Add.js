import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { InputGroup, Form, Button } from "react-bootstrap";
import {v4 as uuid} from "uuid";
import dreams from "./dreams";
import { GrAdd } from "react-icons/gr";
import { GoHome } from "react-icons/go";

function Add()
{
    const [title, setTitle] = useState("");
    const [description, setDescription] = useState("");
    const [lucidity, setLucidity] = useState(0);
    
    let history = useNavigate();
    
    const handleSubmit = (e) => 
    {
        e.preventDefault();

        const ids = uuid();
        let uni = ids.slice(0, 8);
        let t = title,
            d = description,
            l = lucidity;
        
        if (t === "")
        {
            alert("please insert a title.");
            return;
        }
        else if (isNaN(l))
        {
            alert("please insert a numerical lucidity.");
            return;
        }
        else if (l < 0 || l > 1)
        {
            alert("please insert a lucidity value that's between 0 and 1.");
            return;
        }

        dreams.push({id: uni, title: t, description: d, lucidity: l});
        history("/");
    };
    
    return (
        <div className="py-2 container-fluid w-50 bg-secondary">
            <InputGroup className="py-2">
                <InputGroup.Text id="title">title</InputGroup.Text>
                <Form.Control data-testid="title" aria-describedby="title" onChange={(e) => setTitle(e.target.value)} required/>
            </InputGroup>
            <InputGroup className="py-2">
                <InputGroup.Text id="description">description</InputGroup.Text>
                <Form.Control data-testid="description" aria-describedby="description" onChange={(e) => setDescription(e.target.value)} required/>
            </InputGroup>
            <InputGroup className="py-2">
                <InputGroup.Text id="lucidity">lucidity</InputGroup.Text>
                <Form.Control data-testid="lucidity" aria-describedby="lucidity" onChange={(e) => setLucidity(e.target.value)} required/>
            </InputGroup>
            <div className="d-grid py-2">
                <Button data-testid="add" variant="success" type="submit" onClick={(e) => handleSubmit(e)}><GrAdd /></Button>
                <Button variant="dark" onClick={() => {history("/");}}><GoHome /></Button>
            </div>
        </div>
    );
}

export default Add;