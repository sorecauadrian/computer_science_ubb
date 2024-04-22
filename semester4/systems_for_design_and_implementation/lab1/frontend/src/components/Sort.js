import { Form } from "react-bootstrap";

function Sort({sort, onSortChange})
{
    return (
        <Form>
            <Form.Check data-testid='sort' type="radio" label="sort lucidity in descendent order" checked={sort} onChange={(e) => onSortChange(e.target.checked)}/>
        </Form>
    );
}

export default Sort;