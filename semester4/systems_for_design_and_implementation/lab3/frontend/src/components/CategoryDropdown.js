import React, { useEffect, useState } from 'react';
import { Form } from 'react-bootstrap';
import api from '../api';

function CategoryDropdown({ selectedCategory, onCategoryChange }) 
{
    const [categories, setCategories] = useState([]);

    useEffect(() => 
    {
        const fetchCategories = async () => 
        {
            try 
            {
                const response = await api.get('http://localhost:5000/categories');
                setCategories(response.data);
            } 
            catch (error) {console.error('error fetching categories:', error);}
        };

        fetchCategories();
    }, []);

    return (
        <Form.Group controlId="categorySelect" className='d-flex align-items-center'>
            <Form.Label className='me-2 mb-0'>category</Form.Label>
            <Form.Control
                as="select"
                value={selectedCategory}
                onChange={(e) => onCategoryChange(e.target.value)}
            >
                <option value="">all categories</option>
                {categories.map((category) => (
                    <option key={category.id} value={category.name}>
                        {category.name}
                    </option>
                ))}
            </Form.Control>
        </Form.Group>
    );
}

export default CategoryDropdown;
