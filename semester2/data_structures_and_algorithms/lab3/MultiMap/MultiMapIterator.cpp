#include "MultiMapIterator.h"
#include "MultiMap.h"

// Complexity: O(1)
MultiMapIterator::MultiMapIterator(const MultiMap& c): col(c) {pos = c.list.head;}

// Complexity: O(1)
TElem MultiMapIterator::getCurrent() const
{
	if (!valid())
        throw std::exception();
    return col.list.elems[pos].info;
}

// Complexity: O(1)
bool MultiMapIterator::valid() const {return pos != -1;}

// Complexity: O(1)
void MultiMapIterator::next()
{
    if (!valid())
        throw exception();
    pos = col.list.elems[pos].next;
}

// Complexity: O(1)
void MultiMapIterator::first() {pos = col.list.head;}

