#include "SMMIterator.h"
#include "SortedMultiMap.h"

SMMIterator::SMMIterator(const SortedMultiMap& d) : map(d){
	//TODO - Implementation
    this -> current = this -> map.root;
    this -> s = {};
    while (this -> current != -1)
    {
        this -> s.push(this -> current);
        this -> current = this -> map.elements[this -> current].left;
    }
    if (!this -> s.empty())
        this -> current = this -> s.top();
}

void SMMIterator::first(){
	//TODO - Implementation
    this -> current = this -> map.root;
    this -> s = {};
    while (this -> current != -1)
    {
        this -> s.push(this -> current);
        this -> current = this -> map.elements[this -> current].left;
    }
    if (!this -> s.empty())
        this -> current = this -> s.top();
}

void SMMIterator::next(){
	//TODO - Implementation
    if (!this -> valid())
        throw std::exception();
    this -> current = this -> s.top();
    this -> s.pop();
    if (this -> map.elements[this -> current].right != -1)
    {
        this -> current = this -> map.elements[this -> current].right;
        while (this -> current != -1)
        {
            this -> s.push(this -> current);
            this -> current = this -> map.elements[this -> current].left;
        }
    }
    if (!this -> s.empty())
        this -> current = this -> s.top();
    else
        this -> current = -1;
}

bool SMMIterator::valid() const{
	//TODO - Implementation
    return this -> current != -1;
}

TElem SMMIterator::getCurrent() const{
	//TODO - Implementation
	if (!this -> valid())
        throw std::exception();
    return this -> map.elements[this -> current].info;
}



