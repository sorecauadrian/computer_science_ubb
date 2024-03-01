#include "ListIterator.h"
#include "IndexedList.h"
#include <exception>

/// BC: theta(1)
/// WC: theta(1)
/// AC: theta(1)
ListIterator::ListIterator(const IndexedList& list) : list(list){
    if (this -> list.isEmpty())
        this -> current_node = nullptr;
    else
        this -> current_node = this -> list.head;
}

/// BC: theta(1)
/// WC: theta(1)
/// AC: theta(1)
void ListIterator::first(){
    if (this -> list.isEmpty())
        this -> current_node = nullptr;
    else
        this -> current_node = this -> list.head;
}

/// BC: theta(1) (throws exception or first element or last element)
/// WC: theta(length) (the element before the last element)
/// AC: O(length)
void ListIterator::next(){
    if (this -> list.size() == 0)
        throw std::exception();
    this -> current_node = this -> current_node -> next;
}

/// BC: theta(1)
/// WC: theta(1)
/// AC: O(1)
bool ListIterator::valid() const{
    return this -> current_node != nullptr;
    //return (this -> current_node != nullptr && this -> list.size() != 0) || this -> list.size() == 0;
}

/// BC: theta(1)
/// WC: theta(1)
/// AC: O(1)
TElem ListIterator::getCurrent() const{
    if (!this -> valid())
        throw std::exception();
    return this -> current_node -> info;

}