#include "MultiMap.h"
#include "MultiMapIterator.h"
#include <exception>

using namespace std;

// Complexity: theta(1)
MultiMap::MultiMap() {this -> length = 0;}

// BC: theta(1)
// WC: theta(size)
// WC (amortised): theta(1)
// AC: O(size)
// AC (amortised): theta(1)
void MultiMap::add(TKey c, TValue v)
{
    if (this -> list.size == this -> list.capacity && this -> list.first_free == -1)
        this -> resize();
    if (this -> list.first_free == -1)
    {
        this -> list.first_free = this -> list.size;
        this -> list.elems[this -> list.first_free] = SLLANode(NULL_TELEM, -1);
        this -> list.size++;
    }
    if (this -> length == 0)
    {
        int copy_first_free = this -> list.first_free;
        this -> list.first_free = this -> list[this -> list.first_free].next;
        this -> list[copy_first_free] = SLLANode(make_pair(c, v), -1);
        this -> list.head = copy_first_free;
        this -> length++;
        return;
    }
    int copy_first_free = this -> list.first_free;
    this -> list.first_free = this -> list[this -> list.first_free].next;
    this -> list.elems[copy_first_free] = SLLANode{make_pair(c, v), this -> list.head};
    this -> list.head = copy_first_free;
    this -> length++;
}

// BC: theta(1) (the list is empty)
// WC: theta(length)
// AC: O(length)
bool MultiMap::remove(TKey c, TValue v)
{
	if (this -> length == 0)
        return false;
    if (this -> length == 1)
    {
        if (this -> list[this -> list.head].info != make_pair(c, v))
            return false;
        this -> list[this -> list.head].next = this -> list.first_free;
        this -> list.first_free = this -> list.head;
        this -> list.head = -1;
        this -> length--;
        return true;
    }
    if (this -> list[this -> list.head].info == make_pair(c, v))
    {
        int copy_new_head = this -> list[this -> list.head].next;
        this -> list[this -> list.head].next = this -> list.first_free;
        this -> list.first_free = this -> list.head;
        this -> list.head = copy_new_head;
        this -> length--;
        return true;
    }
    int pos = -1;
    for (int node = this -> list.head; this -> list[node].next != -1 && pos == -1; node = this -> list[node].next)
        if (make_pair(c, v) == this -> list[this -> list[node].next].info)
            pos = node;
    if (pos == -1)
        return false;
    int aux = this -> list[this -> list[pos].next].next;
    this -> list[this -> list[pos].next].next = this -> list.first_free;
    this -> list.first_free = this -> list[pos].next;
    this -> list[pos].next = aux;
    this -> length--;
    return true;
}

// BC: theta(1) (the list is empty)
// WC: theta(length)
// AC: O(length)
vector<TValue> MultiMap::search(TKey c) const
{
    vector<TValue> values;
    for (int node = this -> list.head; node != -1; node = this -> list.elems[node].next)
        if (this -> list.elems[node].info.first == c)
            values.push_back(this -> list.elems[node].info.second);
    return values;
}

// Complexity: theta(1)
int MultiMap::size() const {return this -> length;}

// Complexity: theta(1)
bool MultiMap::isEmpty() const {return this -> length == 0;}

//Complexity: theta(1)
MultiMapIterator MultiMap::iterator() const {return MultiMapIterator{*this};}

// Complexity: theta(1)
MultiMap::~MultiMap() {delete[] this -> list.elems;}


void MultiMap::resize()
{
    this -> list.capacity *= 2;
    auto* aux = new SLLANode[this -> list.capacity];
    for (int i = 0; i < this -> list.size; i++)
        aux[i] = this -> list.elems[i];

    delete[] this -> list.elems;
    this -> list.elems = aux;
}

// BC: theta(1)
// WC: theta(length)
// AC: O(length)
TKey MultiMap::maxKey() const
{
    if (this -> isEmpty())
        return NULL_TKEY;
    TKey key = this -> list.elems[this -> list.head].info.first;
    for (int node = this -> list.head; node != -1; node = this -> list.elems[node].next)
        if (this -> list.elems[node].info.first > key)
            key = this -> list.elems[node].info.first;
    return key;
}

// Complexity: theta(1)
MultiMap::SLLANode::SLLANode(): info{NULL_TELEM}, next{0} {}

// Complexity: theta(1)
MultiMap::SLLANode::SLLANode(TElem info, int next): info{std::move(info)}, next{next} {}

// Complexity: theta(1)
MultiMap::SLLA::SLLA()
{
    this->capacity = 1;
    this->size = 1;
    this->elems = new SLLANode[this->capacity];
    this->elems[0] = SLLANode(NULL_TELEM, -1);
    this->first_free = 0;
    this->head = -1;
}

// Complexity: theta(1)
MultiMap::SLLANode &MultiMap::SLLA::operator[](int pos) const {return this -> elems[pos];}
