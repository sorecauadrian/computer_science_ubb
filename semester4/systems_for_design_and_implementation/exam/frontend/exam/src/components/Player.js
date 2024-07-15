import React, { useState } from 'react';
import { Card } from 'react-bootstrap';

function Player({ player }) {
    const [showImage, setShowImage] = useState(false);

    const handleCardClick = () => {setShowImage(!showImage);};

    return (
        <Card 
            className='text-center'
            key={player.id}
            onClick={handleCardClick}
            style={{ 
                backgroundColor: player.isTitular ? 'yellow' : 'green',
                borderRadius: '10px'
            }}
        >
            <Card.Body>
                {showImage ? (
                    <Card.Img variant="top" src={player.photo} style={{borderRadius: '10px'}}/>
                ) : (
                    <>
                        <Card.Title>{player.name}</Card.Title>
                        <Card.Text>{player.shirt_no}</Card.Text>
                    </>
                )}
            </Card.Body>
        </Card>
    );
}

export default Player;
