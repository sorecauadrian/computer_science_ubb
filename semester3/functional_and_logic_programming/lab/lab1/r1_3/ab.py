def set(l : list):
    if not l:
        return True
    if l[0] in l[1:]:
        return False
    return set(l[1:])

def nr_of_distinct_elems(l : list):
    if not l:
        return 0
    if l[0] in l[1:]:
        return nr_of_distinct_elems(l[1:])
    return 1 + nr_of_distinct_elems(l[1:])

if __name__ == '__main__':
    l1 = [1, 2, 3, 4]
    l2 = [4, 2, 3, 4]
    print(set(l1))
    print(nr_of_distinct_elems(l1))
    print(set(l2))
    print(nr_of_distinct_elems(l2))

