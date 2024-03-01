#include "SMMIterator.h"
#include "SortedMultiMap.h"
#include <iostream>
#include <vector>
#include <utility>
#include <exception>
using namespace std;


// complexity: theta(capacity)
SortedMultiMap::SortedMultiMap(Relation r) {
	//TODO - Implementation
    this -> relation = r;
    this -> capacity = 20000;
    this -> length = 0;
    this -> elements = new BSTNode[this -> capacity];
    for (int i = 0; i < this -> capacity - 1; i++)
    {
        this -> elements[i].left = i + 1;
        this -> elements[i].right = -1;
    }
    this -> elements[this -> capacity - 1].left = this -> elements[this -> capacity - 1].right = -1;
    this -> root = -1;
    this -> firstEmpty = 0;
}

// wc: O(length)
// bc: theta(1)
// ac: O(length)
void SortedMultiMap::add(TKey c, TValue v) {
	//TODO - Implementation
    this -> root = this ->recursive_add(this -> root, TElem(c, v));
    this -> length++;
}

// wc: O(length)
// bc: theta(1)
// ac: O(length)
vector<TValue> SortedMultiMap::search(TKey c) const {
	//TODO - Implementation
	int node = this -> root;
    while (node != -1 && this -> elements[node].info.first != c)
        if (this -> relation(c, this -> elements[node].info.first))
            node = this -> elements[node].left;
        else
            node = this -> elements[node].right;
    vector<TValue> values;
    while (node != -1 && this -> elements[node].info.first == c)
    {
        values.push_back(this -> elements[node].info.second);
        node = this -> elements[node].left;
    }
    return values;
}

// wc: O(length)
// bc: theta(1)
// ac: O(length)
bool SortedMultiMap::remove(TKey c, TValue v) {
    //TODO - Implementation
    bool removed = false;
    this -> root = recursive_remove(this -> root, TElem(c, v), removed);
    if (removed)
        this -> length--;
    return removed;
}

// complexity: theta(1)
int SortedMultiMap::size() const {
	//TODO - Implementation
    return this -> length;
}

// complexity: theta(1)
bool SortedMultiMap::isEmpty() const {
	//TODO - Implementation
    return this -> length == 0;
}

// complexity: theta(1)
SMMIterator SortedMultiMap::iterator() const {
	return SMMIterator(*this);
}

// complexity: theta(1)
SortedMultiMap::~SortedMultiMap() {
	//TODO - Implementation
    delete[] this -> elements;
}

// complexity: theta(1)
void SortedMultiMap::deallocate(int node)
{
    this -> elements[node].right = -1;
    this -> elements[node].left = this -> firstEmpty;
    this -> firstEmpty = node;
}

// complexity: theta(1)
int SortedMultiMap::allocate() {
    //if (this -> firstEmpty == -1)
        //resize();
    int newNode = this -> firstEmpty;
    this -> firstEmpty = this -> elements[this -> firstEmpty].left;
    return newNode;
}

// complexity: theta(capacity)
void SortedMultiMap::resize()
{
    this -> capacity *= 2;
    auto* newElements = new BSTNode[this -> capacity];
    for (int i = 0; i < this -> capacity / 2; i++)
        newElements[i] = this -> elements[i];
    delete[] this -> elements;
    this -> elements = newElements;
}

// wc: O(length)
// bc: theta(1)
// ac: O(length)
int SortedMultiMap::recursive_add(int node, TElem elem)
{
    if (node == -1)
        node = this -> create_node(elem);
    else
    {
        if (this -> relation(elem.first, this -> elements[node].info.first))
            this -> elements[node].left = recursive_add(this -> elements[node].left, elem);
        else
            this -> elements[node].right = recursive_add(this -> elements[node].right, elem);
    }
    return node;
}

// wc: O(length)
// bc: theta(1)
// ac: O(length)
int SortedMultiMap::recursive_remove(int node, TElem elem, bool &removed)
{
    if (node == -1)
        return node;
    if (elem.first == this -> elements[node].info.first && elem.second == this -> elements[node].info.second)
    {
        int temp;
        removed = true;
        if (this -> elements[node].left != -1 && this -> elements[node].right != -1)
        {
            temp = this -> minimum(this -> elements[node].right);
            this -> elements[node].info = this -> elements[temp].info;
            this -> elements[node].right = recursive_remove(this -> elements[temp].right, elem, removed);
            return node;
        }
        else
        {
            temp = node;
            int repl;
            if (this -> elements[node].left == -1)
                repl = recursive_remove(this -> elements[node].right, elem, removed);
            else
                repl = recursive_remove(this -> elements[node].left, elem, removed);
            this ->deallocate(temp);
            return repl;
        }
    }
    if (this -> relation(elem.first, this -> elements[node].info.first))
        this -> elements[node].left = recursive_remove(this -> elements[node].left, elem, removed);
    else
        this -> elements[node].right = recursive_remove(this -> elements[node].right, elem, removed);
    return node;
}

// wc: O(length)
// bc: theta(1)
// ac: O(length)
int SortedMultiMap::minimum(int node)
{
    while (this -> elements[node].left != -1)
        node = this -> elements[node].left;
    return node;
}

// complexity: theta(1)
int SortedMultiMap::create_node(TElem elem)
{
    int node = allocate();
    if(node != -1)
    {
        this-> elements[node].info = elem;
        this-> elements[node].left = -1;
        this-> elements[node].right = -1;
    }
    return node;
}

// wc: O(length)
// bc: theta(1)
// ac: O(length)
int SortedMultiMap::getValueRange() const
{
    if (this -> isEmpty())
        return -1;

    int min_value = 1000;
    int max_value = -1000;
    this ->traversal(this -> root, min_value, max_value);
    return max_value - min_value;
}

// wc: O(length)
// bc: theta(1)
// ac: O(length)
void SortedMultiMap::traversal(int node, int& min_value, int& max_value) const
{
    if (node == -1)
        return;
    if (min_value > this -> elements[node].info.second)
        min_value = this -> elements[node].info.second;
    if (max_value < this -> elements[node].info.second)
        max_value = this -> elements[node].info.second;
    traversal(this -> elements[node].left, min_value, max_value);
    traversal(this -> elements[node].right, min_value, max_value);
}