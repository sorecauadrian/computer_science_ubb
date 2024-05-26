import { Col, Form, Row} from "react-bootstrap";
import { FaSortAmountDownAlt } from "react-icons/fa";
import { FaSortAmountUp } from "react-icons/fa";

function Sort({sort, onSortChange})
{
    return (
        <Row className="justify-content-center mb-0 me-2">
            <Col sm="auto">
                <Form.Check inline type="radio" checked={sort === 'ascending'} onChange={() => onSortChange('ascending')}/><FaSortAmountDownAlt/>
            </Col>
            <Col sm="auto">
                <Form.Check inline type="radio" checked={sort === 'descending'} onChange={() => onSortChange('descending')}/><FaSortAmountUp/>
            </Col>
        </Row>
    );
}

export default Sort;