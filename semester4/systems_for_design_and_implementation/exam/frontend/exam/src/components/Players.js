import React, { useEffect } from 'react';
import { Row, Col, Container } from 'react-bootstrap';
import Player from './Player.js';
import api from '../api';
import './Players.css';

function Players({ players, setPlayers, sortShirt, sortName }) {
    useEffect(() => {
        const fetchPlayers = async () => {
            try {
                const response = await api.get(`/players?sortShirt=${sortShirt}&sortName=${sortName}`);
                setPlayers(response.data.players);
            } catch (error) {
                console.error('error fetching players: ', error);
            }
        };

        fetchPlayers();
    }, [setPlayers, sortShirt, sortName]);

    const firstRowPlayers = players.slice(0, 10);
    const secondRowPlayers = players.slice(10, 20);

    return (
        <Container>
            <Row className="custom-row">
                {firstRowPlayers.map((player) => (
                    <Col className="custom-col" key={player.id}>
                        <Player player={player} />
                    </Col>
                ))}
            </Row>
            <Row className="custom-row">
                {secondRowPlayers.map((player) => (
                    <Col className="custom-col" key={player.id}>
                        <Player player={player} />
                    </Col>
                ))}
            </Row>
        </Container>
    );
}

export default Players;
