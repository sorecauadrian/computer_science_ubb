import { Button, Card } from 'react-bootstrap';
import { FaTrashCan } from "react-icons/fa6";
import { TiEdit } from "react-icons/ti";
import { useNavigate } from 'react-router-dom';

function Dream({dream, handleDelete, handleEdit})
{
    let history = useNavigate();

    return (
        <Card className='text-center my-2 text-white border-5' bg={"dark"} border={dream.lucidity >= 0.8 ? "success" : "danger"} key={dream.id}>
            <Card.Header as={'h3'}>{dream.title} <mark>({dream.lucidity})</mark></Card.Header>
            <Card.Body>
                <Card.Text>
                    {dream.description}
                </Card.Text>
            </Card.Body>
            <Card.Footer>
                <div className='d-grid gap-2'>
                    <Button data-testid='edit' variant="warning" onClick={(e) => {handleEdit(dream.id, dream.title, dream.description, dream.lucidity); history('/edit');}}><TiEdit /></Button>
                    <Button data-testid='delete' variant="danger" onClick={(e) => {handleDelete(dream.id);}}><FaTrashCan /></Button>
                </div>
            </Card.Footer>
        </Card>
    );
}

export default Dream;