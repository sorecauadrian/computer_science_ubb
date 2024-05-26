import { useState, useEffect } from 'react';
import { Button, Card } from 'react-bootstrap';
import { FaTrashCan } from "react-icons/fa6";
import { TiEdit } from "react-icons/ti";
import { useNavigate } from 'react-router-dom';

function Product({product, handleDelete, handleEdit})
{
    let history = useNavigate();
    const [cardsPerRow, setCardsPerRow] = useState(getCardsPerRow());

    useEffect(() => 
    {
        const handleResize = () => {setCardsPerRow(getCardsPerRow());};

        window.addEventListener('resize', handleResize);

        return () => {window.removeEventListener('resize', handleResize);};
    }, []);

    function getCardsPerRow() 
    {
        const width = window.innerWidth;
        if (width >= 1200)
            return 6;
        else if (width >= 992)
            return 5;
        else if (width >= 768)
            return 4;
        else
            return 3;
    }

    return (
        <Card className='m-1' key={product.id} style={{ maxWidth: `calc(${100 / cardsPerRow}% - 8px)`, flexBasis: `calc(${100 / cardsPerRow}%)`, borderRadius: '10px' }}>
            <Card.Img variant='top' src={product.image} style={{borderRadius: '10px'}}></Card.Img>
            <Card.Body>
                <Card.Title>{product.title}</Card.Title>
                <Card.Text>{product.price} RON</Card.Text>
            </Card.Body>
            <Card.Footer>
                <div className='d-grid gap-2'>
                    <Button data-testid='edit' variant="warning" onClick={(e) => {handleEdit(product.id, product.title, product.price, product.image, product.categoryId); history('/edit');}}><TiEdit /></Button>
                    <Button data-testid='delete' variant="danger" onClick={(e) => {handleDelete(product.id); history('/');}}><FaTrashCan /></Button>
                </div>
            </Card.Footer>
        </Card>
    );
}

export default Product;