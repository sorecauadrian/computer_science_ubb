import { InputGroup, Form } from "react-bootstrap";
import { GoSearch } from "react-icons/go";

function SearchBar({filterText, onFilterTextChange})
{
    return (
        <InputGroup>
            <InputGroup.Text id="search"><GoSearch /></InputGroup.Text>
            <Form.Control aria-label="default" aria-describedby="search" value={filterText} onChange={(e) => onFilterTextChange(e.target.value)}/>
        </InputGroup>
    );
}

export default SearchBar;