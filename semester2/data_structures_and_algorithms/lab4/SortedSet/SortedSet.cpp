#include "SortedSet.h"
#include "SortedSetIterator.h"

// complexity: theta(1)
SortedSet::SortedSet(Relation r)
{
	//TODO - Implementation
    this -> r = r;
    this -> capacity = 2;
    this -> length = 0;
    this -> elements = new TElem[capacity];
    this -> occupied = new bool[capacity]();
}

// wc: O(capacity)
// bc: theta(1)
// ac: O(capacity)
bool SortedSet::add(TComp elem) {
	//TODO - Implementation
    if (this -> length == this -> capacity)
        this -> resize();
    int index = hash1(elem);
    int step = hash2(elem, this -> capacity);
    int count = 0;
    while (count < this -> capacity && this -> occupied[index] && this -> elements[index] != elem)
    {
        index = (index + step) % this->capacity;
        count++;
    }

    if (!this -> occupied[index])
    {
        this -> elements[index] = elem;
        this -> occupied[index] = true;
        this -> length++;
        return true;
    }
    return false;
}

// wc: O(capacity)
// bc: theta(1)
// ac: O(capacity)
bool SortedSet::remove(TComp elem) {
	//TODO - Implementation
    if (this -> length == 0)
        return false;

	int index = hash1(elem);
    int step = hash2(elem, this -> capacity);
    int count = 0;

    while (count < this -> capacity && this -> elements[index] != elem)
    {
        index = (index + step) % this -> capacity;
        count++;
    }
    if (this -> elements[index] == elem)
    {
        this -> occupied[index] = false;
        this -> elements[index] = NULL_TELEM;
        this -> length--;
        return true;
    }
    return false;
}

// wc: O(capacity)
// bc: theta(1)
// ac: O(capacity)
bool SortedSet::search(TComp elem) const {
	//TODO - Implementation
    if (this -> length == 0)
        return false;

	int index = hash1(elem);
    int step = hash2(elem, this -> capacity);
    int count = 0;
    while (count < this -> capacity && this -> occupied[index])
    {
        if (this -> elements[index] == elem)
            return true;
        index = (index + step) % this -> capacity;
        count++;
    }
    return false;
}

// complexity: theta(1)
int SortedSet::size() const {
	//TODO - Implementation
    return this -> length;
}

// complexity: theta(1)
bool SortedSet::isEmpty() const {
	//TODO - Implementation
    return this -> length == 0;
}

// complexity: theta(1)
SortedSetIterator SortedSet::iterator() const {
	return SortedSetIterator(*this);
}

// complexity: theta(1)
SortedSet::~SortedSet() {
	//TODO - Implementation
    delete[] this -> elements;
    delete[] this -> occupied;
}

// complexity: O(capacity)
void SortedSet::resize()
{
    int oldCapacity = this -> capacity;
    this -> capacity *= 2;
    while (!isPrime(this -> capacity))
        this -> capacity++;
    auto* newElements = new TElem[this -> capacity];
    bool* newOccupied = new bool[this -> capacity];

    for (int i = 0; i < this -> capacity; i++)
    {
        newElements[i] = NULL_TELEM;
        newOccupied[i] = false;
    }

    for (int i = 0; i < oldCapacity; i++)
        if (this -> occupied[i])
        {
            int index = hash1(this -> elements[i]);
            int step = hash2(this -> elements[i], this -> capacity);
            int count = 0;

            while (count < this -> capacity && newOccupied[index])
            {
                index = (index + step) % this -> capacity;
                count++;
            }

            newElements[index] = this -> elements[i];
            newOccupied[index] = true;
        }
    delete[] this -> elements;
    delete[] this -> occupied;

    this -> elements = newElements;
    this -> occupied = newOccupied;
}

bool SortedSet::isPrime(int number)
{
    if (number < 2 || (number > 2 && number % 2 == 0))
        return false;
    for (int i = 3; i * i <= number; i++)
        if (number % i == 0)
            return false;
    return true;
}


// complexity: O(length)
void SortedSet::intersection(SortedSet &s)
{
    SortedSetIterator ssi = s.iterator();
    SortedSetIterator ssis = this->iterator();
    while (ssi.valid())
    {
        if (!this -> search(ssi.getCurrent()))
            s.remove(ssi.getCurrent());
        ssi.next();
    }
    while (ssis.valid())
    {
        if (!s.search(ssis.getCurrent()))
            this -> remove(ssis.getCurrent());
        ssis.next();
    }
}


