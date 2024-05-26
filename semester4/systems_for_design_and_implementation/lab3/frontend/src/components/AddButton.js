import { Button } from 'react-bootstrap';
import { GrAdd } from "react-icons/gr";
import { useNavigate } from 'react-router-dom';

function AddButton()
{
    let history = useNavigate();
    return (
        <div className='d-grid'>
            <Button data-testid="add" variant='success' onClick={() => {history('./add');}}><GrAdd /></Button>
        </div>
    );

}

export default AddButton;