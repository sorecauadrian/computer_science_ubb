#include <exception>

#include "IndexedList.h"
#include "ListIterator.h"

/// BC: theta(capacity)
/// WC: theta(capacity)
/// AC: O(capacity)
IndexedList::IndexedList() {
    this -> capacity = 1;
    this -> head = nullptr;
    this -> tail = nullptr;
    this -> length = 0;
}

/// BC: theta(1)
/// WC: theta(1)
/// AC: O(1)
int IndexedList::size() const {

    return this -> length;
}

/// BC: theta(1)
/// WC: theta(1)
/// AC: O(1)
bool IndexedList::isEmpty() const {
    return this -> length == 0;
}

/// BC: theta(1) (throws exception or first element)
/// WC: theta(length) (last element)
/// AC: O(length)
TElem IndexedList::getElement(int pos) const {
    if (pos > this -> length)
        throw std::exception();
    DLLNode* current = this -> head;
    int counter = 0;
    while (current != nullptr)
    {
        if (counter == pos)
            return current -> info;
        else
        {
            current = current -> next;
            counter++;
        }
    }
    throw std::exception();
}

/// BC: theta(1) (throws exception or first element)
/// WC: theta(length) (last element)
/// AC: O(length)
TElem IndexedList::setElement(int pos, TElem e) {
    if (pos > this -> length)
        throw std::exception();
    DLLNode* current = this -> head;
    int counter = 0;
    while (current != nullptr)
    {
        if (counter == pos)
        {
            TElem copy = current -> info;
            current -> info = e;
            return copy;
        }
        else
        {
            current = current -> next;
            counter++;
        }
    }
    throw std::exception();
}

/// BC: theta(1)
/// WC: theta(capacity) (resize)
/// AC: O(capacity) (usually we don't have to resize)
void IndexedList::addToEnd(TElem e) {

    auto* new_node = new DLLNode();
    if (this -> length == 0)
    {
        new_node -> info = e;
        new_node -> prev = nullptr;
        new_node -> next = nullptr;

        this -> head = new_node;
        this -> tail = new_node;
    }
    else
    {
        new_node -> info = e;
        new_node -> prev = this -> tail;
        new_node -> next = nullptr;


        this -> tail -> next = new_node;
        this -> tail = new_node;
    }
    this -> length++;
}

/// BC: theta(1) (throws exception)
/// WC: theta(length+capacity) (the element before the last one, resize)
/// AC: O(capacity)
void IndexedList::addToPosition(int pos, TElem e) {
    if (pos > this -> length)
        throw std::exception();

    auto* new_node = new DLLNode();
    if (this -> length == 0)
    {
        new_node -> info = e;
        new_node -> prev = nullptr;
        new_node -> next = nullptr;

        this -> head = new_node;
        this -> tail = new_node;
    }
    else if (pos == 0)
    {
        new_node -> info = e;
        new_node -> prev = nullptr;
        new_node -> next = this -> head;

        this -> head -> prev = new_node;
        this -> head = new_node;
    }
    else if (pos == this -> length)
    {
        new_node -> info = e;
        new_node -> prev = this -> tail;
        new_node -> next = nullptr;

        this -> tail -> next = new_node;
        this -> tail = new_node;
    }
    else
    {
        auto counter = 0;
        auto current = this -> head;
        while (current != nullptr)
        {
            if (counter == pos)
            {
                new_node -> info = e;
                new_node -> next = current;
                new_node -> prev = current -> prev;

                current -> prev -> next = new_node;
                current -> prev = new_node;
                break;
            }
            else
            {
                current = current -> next;
                counter++;
            }
        }
    }
    this -> length++;
}

/// BC: theta(1) (throws exception)
/// WC: theta(length) (the element before the last one)
/// AC: O(length)
TElem IndexedList::remove(int pos) {
    if (pos > this -> length || this -> length == 0)
        throw std::exception();

    if (this -> length == 1)
    {
        auto *copy = this -> head;
        this -> head = nullptr;
        this -> length--;
        return copy -> info;
    }
    else if (pos == 0)
    {
        auto *copy = this -> head;
        this -> head -> next -> prev = nullptr;
        this -> head = this -> head -> next;
        this -> length--;
        return copy -> info;
    }
    else if (pos == this -> length - 1)
    {
        auto *copy = this -> tail;
        this -> tail -> prev -> next = nullptr;
        this -> tail = this -> tail -> prev;
        this -> length--;
        return copy -> info;
    }
    else
    {
        auto *current = this->head;
        auto counter = 0;
        while (current != nullptr) {
            if (counter == pos) {
                auto *copy = current;
                current->next->prev = current->prev;
                current->prev->next = current->next;
                this -> length--;
                return copy->info;
            } else {
                current = current->next;
                counter++;
            }
        }
    }
    throw std::exception();
}

/// BC: theta(1) (first element)
/// WC: theta(length) (last element or nonexistent)
/// AC: O(length)
int IndexedList::search(TElem e) const{
    DLLNode* current = this -> head;
    int counter = 0;
    while (current != nullptr)
    {
        if (current -> info == e)
            return counter;
        current = current -> next;
        counter++;
    }
    return -1;
}

/// BC: theta(1)
/// WC: theta(1)
/// AC: O(1)
ListIterator IndexedList::iterator() const {
    return ListIterator(*this);
}

/// BC: theta(1)
/// WC: theta(1)
/// AC: O(1)
IndexedList::~IndexedList() = default;

/// BC: theta(1) (last element)
/// WC: theta(length) (first element or nonexistent)
/// AC: O(length)
int IndexedList::lastIndexOf(TElem elem) const {
    DLLNode* current = this -> tail;
    int counter = this -> size() - 1;
    while (current != nullptr)
    {
        if (current -> info == elem)
            return counter;
        current = current -> prev;
        counter--;
    }
    return -1;
}
