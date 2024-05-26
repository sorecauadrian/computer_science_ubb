import { Pagination } from 'react-bootstrap';

function PaginationControls({ currentPage, totalPages, onPageChange }) {
    return (
        <div className='d-flex justify-content-center'>
            <Pagination>
                <Pagination.First onClick={() => onPageChange(1)} />
                <Pagination.Prev onClick={() => onPageChange(currentPage - 1)} disabled={currentPage === 1} />
                {[...Array(totalPages).keys()].map((pageNumber) => (
                    <Pagination.Item key={pageNumber + 1} onClick={() => onPageChange(pageNumber + 1)} active={currentPage === pageNumber + 1}>
                        {pageNumber + 1}
                    </Pagination.Item>
                ))}
                <Pagination.Next onClick={() => onPageChange(currentPage + 1)} disabled={currentPage === totalPages} />
                <Pagination.Last onClick={() => onPageChange(totalPages)} />
            </Pagination>
        </div>
    );
}

export default PaginationControls;
