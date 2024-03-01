#include "Matrix.h"
#include <exception>
#include <stdexcept>

using namespace std;

Matrix::Matrix(int nrLines, int nrCols) {
    nrL = nrLines;
    nrC = nrCols;
    length = 0;
    capacity = 1;
    elems = new tuple<int, int, TElem>[capacity];
}

int Matrix::nrLines() const
{
	return nrL;
}

int Matrix::nrColumns() const
{
	return nrC;
}

TElem Matrix::element(int i, int j) const
{
    if (i < 0 || j < 0 || i >= nrL || j >= nrC)
        throw std::invalid_argument("out of matrix.");
    else
        for (int k = 0; k < length; k++)
            if (get<0>(elems[k]) == i && get<1>(elems[k]) == j)
                return get<2>(elems[k]);
    return NULL_TELEM;
}



TElem Matrix::modify(int i, int j, TElem e)
{
    if (i < 0 || j < 0 || i >= nrL || j >= nrC)// if the element is out of the matrix
        throw std::invalid_argument("out of matrix.");
    else // the element is in the matrix
    {
        // trying to find if the element exists
        /* wc: O(length), ac: O(length / 2), bc: O(1)
        for (int k = 0; k < length; k++)
            if (get<0>(elems[k]) == i && get<1>(elems[k]) == j)
            {
                if (e == 0) // eliminating an existing element
                {
                    TElem deleted_cost = get<2>(elems[k]);
                    for (int h = k; h < length - 1; h++)
                        elems[h] = elems[h + 1];
                    length--;
                    return deleted_cost;
                } else // updating the cost of an existing element
                {
                    tuple<int, int, TElem> current = make_tuple(i, j, e);
                    elems[k].swap(current);
                    return get<2>(current);
                }
            }
        */
        // wc: O(log(length)), ac: O(log(length)), bc: O(1)
        int low = 0, high = length - 1;
        while (low <= high)
        {
            int mid = (low + high) / 2;
            if (get<0>(elems[mid]) == i && get<1>(elems[mid]) == j) // we found the element!
            {
                if (e == 0) // eliminating an existing element
                // wc: O(length*log(length)), ac: O(length*log(length)), bc: O(log(length))
                {
                    TElem deleted_cost = get<2>(elems[mid]);
                    for (int h = mid; h < length - 1; h++)
                        elems[h] = elems[h + 1];
                    length--;
                    return deleted_cost;
                }
                else // updating the cost of an existing element
                // O(1)
                {
                    tuple<int, int, TElem> current = make_tuple(i, j, e);
                    elems[mid].swap(current);
                    return get<2>(current);
                }
            }
            else if (get<0>(elems[mid]) < i || (get<0>(elems[mid]) == i && get<1>(elems[mid]) < j))
                low = mid + 1;
            else
                high = mid - 1;
        }
        // it didn't return anything, thus the cost has value 0
        if (e != 0)// adding an element
        {
            if (capacity == length) // resizing if the dynamic array is full
            {
                capacity *= 2;
                auto new_elems = new tuple<int, int, TElem>[capacity];
                for (int k = 0; k < length; k++)
                    new_elems[k] = elems[k];
                delete[] elems;
                elems = new_elems;
            }
            if (length < 1) // if the dynamic array is empty
                elems[0] = make_tuple(i, j, e);
            else if (i < get<0>(elems[0]) || (i == get<0>(elems[0]) && j < get<1>(elems[0]))) // if it should be the first element in the dynamic array
            {
                for (int k = length; k >= 1; k--)
                    elems[k] = elems[k - 1];
                elems[0] = make_tuple(i, j, e);
            }
            else if (i > get<0>(elems[length - 1]) || (i == get<0>(elems[length - 1]) && j > get<1>(elems[length - 1]))) // if it should be the last element in the dynamic array
                elems[length] = make_tuple(i, j, e);
            else
            {
                /* wc: O(length), ac: O(length / 2), bc: O(1)
                for (int k = 0; k < length - 1; k++)
                    if ((i > get<0>(elems[k]) || (i == get<0>(elems[k]) && j > get<1>(elems[k]))) &&
                        (i < get<0>(elems[k + 1]) || (i == get<0>(elems[k + 1]) && j < get<1>(elems[k + 1])))) {
                        for (int h = length; h >= k + 2; h--)
                            elems[h] = elems[h - 1];
                        elems[k + 1] = make_tuple(i, j, e);
                        break;
                    }
                */
                // wc: O(log(length)), ac: O(log(length)), bc: O(1)
                int other_low = 0, other_high = length - 2;
                while (other_low <= other_high)
                {
                    int other_mid = (other_high + other_low) / 2;
                    if ((i > get<0>(elems[other_mid]) || (i == get<0>(elems[other_mid]) && j > get<1>(elems[other_mid]))) &&
                        (i < get<0>(elems[other_mid + 1]) || (i == get<0>(elems[other_mid + 1]) && j < get<1>(elems[other_mid + 1])))) // if it should belong between two elements, then add it there
                    { // wc: O(length * log(length)), ac: O(length * log(length)), bc: O(log(length))
                        for (int h = length; h >= other_mid + 2; h--)
                            elems[h] = elems[h - 1];
                        elems[other_mid + 1] = make_tuple(i, j, e);
                        break;
                    }
                    else if (get<0>(elems[other_mid]) < i || (get<0>(elems[other_mid]) == i && get<1>(elems[other_mid]) < j))
                        other_low = other_mid + 1;
                    else
                        other_high = other_mid - 1;
                }
            }
            length++;
        }
        return NULL_TELEM;
    }
}

// wc: O(nrL * length * log(length)), ac: O(nrL * length * log(length)), bc: O(nrL * log(length))
void Matrix::setElemsOnCol(int col, TElem e)
{
    if (col < 0 || col >= nrC)
        throw std::invalid_argument("out of matrix.");
    for (int i = 0; i < nrL; i++)
        modify(i, col, e);
}

Matrix::~Matrix()
{
    delete[] elems;
}

