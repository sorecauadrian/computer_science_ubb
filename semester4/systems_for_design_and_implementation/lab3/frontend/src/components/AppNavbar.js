import React from 'react';
import { Navbar, Container } from 'react-bootstrap';
import Logo from './Logo';

function AppNavbar() 
{
    return (
        <Navbar bg="dark" variant="dark">
            <Container>
                <Navbar.Brand>
                    <Logo />
                    <span className="ms-2">human wearing</span>
                </Navbar.Brand>
            </Container>
        </Navbar>
    );
}

export default AppNavbar;
