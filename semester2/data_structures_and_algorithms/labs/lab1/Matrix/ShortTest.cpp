#include <assert.h>
#include "Matrix.h"
#include <exception>

using namespace std;

void testAll() { 
	Matrix m(4, 4);
	assert(m.nrLines() == 4);
	assert(m.nrColumns() == 4);	
	m.modify(1, 1, 5);
	assert(m.element(1, 1) == 5);
	TElem old = m.modify(1, 1, 6);
	assert(m.element(1, 2) == NULL_TELEM);
	assert(old == 5);
    // testing the setElemsOnCol function
    m.setElemsOnCol(2, 3);
    for (int i = 0; i < m.nrLines(); i++)
        assert(m.element(i, 2) == 3);
    try {
        m.setElemsOnCol(5, 6);
        assert(false);
    }
    catch (exception&) {
        assert(true);
    }
}