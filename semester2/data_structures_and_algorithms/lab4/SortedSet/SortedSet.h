#pragma once
//DO NOT INCLUDE SETITERATOR

//DO NOT CHANGE THIS PART
typedef int TElem;
typedef TElem TComp;
typedef bool(*Relation)(TComp, TComp);
#define NULL_TELEM -11111
class SortedSetIterator;

#include <cstdlib>

class SortedSet {
	friend class SortedSetIterator;
private:
	//TODO - Representation
    int capacity;
    int length;
    Relation r;
    TElem* elements;
    bool* occupied;
    int hash1(int key) const {return abs(key) % this -> capacity;}
    int hash2(int key, int capacity) const
    {
        if (capacity == 0)
            return 1;
        return 1 + (abs(key) % (capacity - 1));
    }
    void resize();
    static bool isPrime(int number);
public:
	//constructor
	SortedSet(Relation r);

	//adds an element to the sorted set
	//if the element was added, the operation returns true, otherwise (if the element was already in the set) 
	//it returns false
	bool add(TComp e);

	
	//removes an element from the sorted set
	//if the element was removed, it returns true, otherwise false
	bool remove(TComp e);

	//checks if an element is in the sorted set
	bool search(TElem elem) const;


	//returns the number of elements from the sorted set
	int size() const;

	//checks if the sorted set is empty
	bool isEmpty() const;

	//returns an iterator for the sorted set
	SortedSetIterator iterator() const;

	// destructor
	~SortedSet();

    void intersection(SortedSet& s);
};
