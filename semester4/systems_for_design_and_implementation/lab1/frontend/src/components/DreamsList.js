import Dream from './Dream.js'
import dreams from './dreams.js'
import { useNavigate } from 'react-router-dom';
import { Button, Form, Pagination } from 'react-bootstrap';
import { GrAdd } from "react-icons/gr";
import { useState } from 'react';

function DreamsList({filterText, lucid, sort}) 
{
    const [page, setPage] = useState(1);

    const [dreamsPerPage, setDreamsPerPage] = useState(5);

    const dreamsPerPageOptions = [5, 15, 50];

    const handleChangeDreamsPerPage = (e) => {
        setDreamsPerPage(parseInt(e.target.value));
        setPage(1);
    };

    if (sort)
        dreams.sort(function (dream1, dream2) {return dream2.lucidity - dream1.lucidity;});

    const filteredDreams = dreams.filter(dream => dream.title.includes(filterText));
    const lucidDreams = filteredDreams.filter(dream => dream.lucidity >= 0.8)

    const startIndex = (page - 1) * dreamsPerPage;
    const endIndex = startIndex + dreamsPerPage;
    let displayedDreams;
    if (lucid)
        displayedDreams = lucidDreams.slice(startIndex, endIndex);
    else 
        displayedDreams = filteredDreams.slice(startIndex, endIndex);


    let history = useNavigate();

    function setID(id, title, description, lucidity)
    {
        localStorage.setItem("id", id);
        localStorage.setItem("title", title);
        localStorage.setItem("description", description);
        localStorage.setItem("lucidity", lucidity);
    }

    function handleDelete(id)
    {
        let index = dreams.map(function (e) {return e.id;}).indexOf(id);
        dreams.splice(index, 1);
        history("/");
    }

    function totalPages() {return Math.ceil((lucid? lucidDreams.length / dreamsPerPage : filteredDreams.length / dreamsPerPage));}
    
    return (
        <>  
            <div className='d-grid'>
                <Button data-testid="add" variant='success' onClick={() => {history('./add');}}><GrAdd /></Button>
            </div>
            {displayedDreams.map((dream) => {return (<Dream data-testid='dream' dream={dream} key={dream.id} handleDelete={handleDelete} handleEdit={setID}/>);})}
            <div className='d-flex justify-content-center'>
                <Pagination>
                    <Pagination.First onClick={() => setPage(1)}/>
                    <Pagination.Prev onClick={() => setPage(page - 1)} disabled={page === 1}/>
                    {[...Array(totalPages()).keys()].map((pageNumber) => (
                        <Pagination.Item key={pageNumber + 1} onClick={() => setPage(pageNumber + 1)} active={page === pageNumber + 1}>
                            {pageNumber + 1}
                        </Pagination.Item>
                    ))}
                    <Pagination.Next onClick={() => setPage(page + 1)} disabled={page === totalPages()} />
                    <Pagination.Last onClick={() => setPage(totalPages())} />
                </Pagination>
            </div>
            <div>
                <Form.Label>dreams per page: </Form.Label>
                <Form.Select className='mx-2' value={dreamsPerPage} onChange={handleChangeDreamsPerPage}>
                    {dreamsPerPageOptions.map((option) => (
                    <option key={option} value={option}>
                        {option}
                    </option>
                    ))}
                </Form.Select>
            </div>
        </>
    );
}

export default DreamsList;