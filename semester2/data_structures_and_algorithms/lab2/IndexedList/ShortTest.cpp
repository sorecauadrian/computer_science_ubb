#include <assert.h>
#include <exception>

#include "ShortTest.h"
#include "IndexedList.h"
#include "ListIterator.h"

void testAll() {
    IndexedList list = IndexedList();
    assert(list.isEmpty());
    list.addToEnd(1);
    assert(list.size() == 1);
    list.addToPosition(0,2);
    assert(list.size() == 2);
    ListIterator it = list.iterator();
    assert(it.valid());
    it.next();
    assert(it.getCurrent() == 1);
    it.first();
    assert(it.getCurrent() == 2);
    assert(list.search(1) == 1);
    assert(list.setElement(1,3) == 1);
    assert(list.getElement(1) == 3);
    assert(list.remove(0) == 2);
    assert(list.size() == 1);

    IndexedList list_bonus = IndexedList();
    list_bonus.addToEnd(1);
    list_bonus.addToEnd(2);
    list_bonus.addToEnd(3);
    list_bonus.addToEnd(1);
    list_bonus.addToEnd(3);
    list_bonus.addToEnd(3);
    assert(list_bonus.size() == 6);
    assert(list_bonus.lastIndexOf(1) == 3);
    assert(list_bonus.lastIndexOf(2) == 1);
    assert(list_bonus.lastIndexOf(3) == 5);
    assert(list_bonus.lastIndexOf(4) == -1);

}
