import PaginationControls from "./PaginationControls.js";
import PaginationOptions from "./PaginationOptions.js";

function PaginationFooter({currentPage, onPageChange, totalPages, productsPerPage, handleChangeProductsPerPage, totalProducts}) 
{
    return (
    <div className="d-flex justify-content-between">
        <PaginationOptions productsPerPage={productsPerPage} handleChange={handleChangeProductsPerPage} totalProducts={totalProducts}/>
        <PaginationControls currentPage={currentPage} totalPages={totalPages} onPageChange={onPageChange} />
    </div>
    );
}

export default PaginationFooter;