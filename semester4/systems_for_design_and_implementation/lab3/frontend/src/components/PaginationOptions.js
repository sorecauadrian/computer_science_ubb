import { Form } from 'react-bootstrap';

function PaginationOptions({ productsPerPage, handleChange, totalProducts }) {
    const productsPerPageOptions = [12, 24, 48];
    return (
        <div className='d-flex align-items-center w-50'>
            <Form.Label>showing </Form.Label>
            <Form.Select className='mx-2 w-50' value={productsPerPage} onChange={handleChange}>
                {productsPerPageOptions.map((option) => (
                    <option key={option} value={option}>
                        {option}
                    </option>
                ))}
            </Form.Select>
            <Form.Label> out of {totalProducts}</Form.Label>
        </div>
    );
}

export default PaginationOptions;
