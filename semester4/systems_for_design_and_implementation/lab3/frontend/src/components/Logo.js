import { useNavigate } from 'react-router-dom';
import logo from '../assets/logos/temporary_logo.jpg';
import { Image } from 'react-bootstrap';

function Logo()
{
    let history = useNavigate();

    return (
        <Image onClick={() => {history('/');}} style={{width: '40px'}} src={logo} alt="logo" fluid/>
    );
}

export default Logo;