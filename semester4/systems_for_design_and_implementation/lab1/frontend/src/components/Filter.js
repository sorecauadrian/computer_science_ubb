import { Form } from "react-bootstrap";

function Filter ({lucid, onLucidChange})
{
    return (
        <Form>
            <Form.Check data-testid="filter" type="switch" label="only show lucid dreams (lucidity >= 0.8)" checked={lucid} onChange={(e) => onLucidChange(e.target.checked)}/>
        </Form>
    );
}

export default Filter;