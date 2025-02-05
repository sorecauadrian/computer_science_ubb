#pragma once
#include "IndexedList.h"


class ListIterator{
    //DO NOT CHANGE THIS PART
    friend class IndexedList;
private:
    const IndexedList& list;
    //TODO - Representation
    DLLNode* current_node;

    explicit ListIterator(const IndexedList& lista);
public:
    void first();
    void next();
    bool valid() const;
    TElem getCurrent() const;

};

