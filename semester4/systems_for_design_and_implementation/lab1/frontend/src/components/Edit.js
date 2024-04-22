import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { InputGroup, Form, Button } from "react-bootstrap";
import dreams from "./dreams";
import { TiEdit } from "react-icons/ti";
import { GoHome } from "react-icons/go";

function Edit()
{
    const [id, setId] = useState("");
    const [title, setTitle] = useState("");
    const [description, setDescription] = useState("");
    const [lucidity, setLucidity] = useState(0);

    let history = useNavigate();
    let index = dreams.map(function (e) {return e.id;}).indexOf(id);

    const handleSubmit = (e) =>
    {
        e.preventDefault();
        if (title === "")
        {
            alert("please insert a title.");
            return;
        }
        else if (isNaN(lucidity))
        {
            alert("please insert a numerical lucidity.");
            return;
        }
        else if (lucidity < 0 || lucidity > 1)
        {
            alert("please insert a lucidity value that's between 0 and 1.");
            return;
        }

        let a = dreams[index];
        
        a.title = title;
        a.description = description;
        a.lucidity = lucidity;

        history("/");
    }

    useEffect(() => {
        setId(localStorage.getItem("id"));
        setTitle(localStorage.getItem("title"));
        setDescription(localStorage.getItem("description"));
        setLucidity(localStorage.getItem("lucidity"));
    }, []);

    return (
        <div className="py-2 container-fluid w-50 bg-secondary">
            <InputGroup className="py-2">
                <InputGroup.Text id="title">title</InputGroup.Text>
                <Form.Control data-testid="title" aria-describedby="title" value={title} onChange={(e) => setTitle(e.target.value)}/>
            </InputGroup>
            <InputGroup className="py-2">
                <InputGroup.Text id="description">description</InputGroup.Text>
                <Form.Control data-testid="description" aria-describedby="description" value={description} onChange={(e) => setDescription(e.target.value)}/>
            </InputGroup>
            <InputGroup className="py-2">
                <InputGroup.Text id="lucidity">lucidity</InputGroup.Text>
                <Form.Control data-testid="lucidity" aria-describedby="lucidity" value={lucidity} onChange={(e) => setLucidity(e.target.value)}/>
            </InputGroup>
            <div className="d-grid py-2">
                <Button data-testid="edit" variant="warning" type="submit" onClick={(e) => handleSubmit(e)}><TiEdit /></Button>
                <Button variant="dark" onClick={() => {history('/');}}><GoHome /></Button>
            </div>
        </div>
    );
}

export default Edit;