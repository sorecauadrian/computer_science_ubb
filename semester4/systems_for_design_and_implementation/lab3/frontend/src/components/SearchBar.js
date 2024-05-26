import { InputGroup, Form, Button } from "react-bootstrap";
import { GoSearch } from "react-icons/go";

function SearchBar({filterText, onFilterTextChange})
{
    return (
        <InputGroup>
            <Form.Control aria-label="default" value={filterText} onChange={(e) => onFilterTextChange(e.target.value)}/>
            <Button variant="secondary"><GoSearch /></Button>
        </InputGroup>
    );
}

export default SearchBar;