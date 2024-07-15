import { Col, Form, Row} from "react-bootstrap";
import { FaSortAmountDownAlt } from "react-icons/fa";
import { FaSortAmountUp } from "react-icons/fa";

function Sort({sortShirt, onSortShirtChange, sortName, onSortNameChange})
{
    return (
        <>
        <p>sort by shirt number</p>
        <Row className="justify-content-center mb-0 me-2">
            <Col sm="auto">
                <Form.Check inline type="radio" checked={sortShirt === 'ascending'} onChange={() => onSortShirtChange('ascending')}/><FaSortAmountDownAlt/>
            </Col>
            <Col sm="auto">
                <Form.Check inline type="radio" checked={sortShirt === 'descending'} onChange={() => onSortShirtChange('descending')}/><FaSortAmountUp/>
            </Col>
        </Row>
        <p>sort by name</p>
        <Row className="justify-content-center mb-0 me-2">
            <Col sm="auto">
                <Form.Check inline type="radio" checked={sortName === 'ascending'} onChange={() => onSortNameChange('ascending')}/><FaSortAmountDownAlt/>
            </Col>
            <Col sm="auto">
                <Form.Check inline type="radio" checked={sortName === 'descending'} onChange={() => onSortNameChange('descending')}/><FaSortAmountUp/>
            </Col>
        </Row>
        </>
    );
}

export default Sort;