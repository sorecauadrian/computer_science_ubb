#include "SortedSetIterator.h"
#include <exception>

using namespace std;

SortedSetIterator::SortedSetIterator(const SortedSet& m) : multime(m)
{
	//TODO - Implementation
    this -> size = m.size();
    this -> elements = new TElem[this -> size];
    this -> currentIndex = 0;

    int index = 0;
    for (int i = 0; i < m.capacity; i++)
        if (m.occupied[i])
            this -> elements[index++] = m.elements[i];

    for (int i = 0; i < this -> size - 1; i++)
        for (int j = 0; j < this -> size - i - 1; j++)
            if (m.r(this -> elements[j + 1], this -> elements[j]))
                swap(this -> elements[j + 1], this -> elements[j]);
}


void SortedSetIterator::first() {
	//TODO - Implementation
    this -> currentIndex = 0;
}


void SortedSetIterator::next() {
	//TODO - Implementation
    if (!this -> valid())
        throw std::exception();
    currentIndex++;
}


TElem SortedSetIterator::getCurrent()
{
	//TODO - Implementation
    if (!this -> valid())
        throw std::exception();
    return this -> elements[currentIndex];
}

bool SortedSetIterator::valid() const {
	//TODO - Implementation
    return this -> currentIndex >= 0 && this -> currentIndex < size;
}

