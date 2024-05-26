import React from 'react';
import { Container, Row, Col } from 'react-bootstrap';
import SearchBar from './SearchBar';
import Sort from './Sort';
import CategoryDropdown from './CategoryDropdown';

function ProductFilter({ filterText, setFilterText, sort, setSort, selectedCategory, setSelectedCategory }) 
{
    return (
        <Container>
            <Row className="mb-3">
                <Col>
                    <SearchBar filterText={filterText} onFilterTextChange={setFilterText} />
                </Col>
            </Row>
            <Row className="mb-3">
                <Col>
                    <Sort sort={sort} onSortChange={setSort} />
                </Col>
                <Col>
                    <CategoryDropdown
                        selectedCategory={selectedCategory}
                        onCategoryChange={setSelectedCategory}
                    />
                </Col>
            </Row>
        </Container>
    );
}

export default ProductFilter;
