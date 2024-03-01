class Bag:
    def __init__(self):
        self.__elems = []

    def add(self, e):
        self.__elems.append(e)

    def remove(self, e):
        if e in self.__elems:
            self.__elems.remove(e)
            return True
        return False

    def nrOccurrences(self, e):
        occurrences = 0
        for elem in self.__elems:
            if elem == e:
                occurrences += 1
        return occurrences

    def iterator(self, i):
        i = BagIterator(self)

class BagIterator:
    def __init__(self, b):
        self.__index = 0
        self.__bag = b

    def getCurrent(self):
        if self.valid():
            return self.__bag.__Bag.__elems[self.__index]
        raise ValueError()

    def valid(self):
        if self.__index < len(self.__bag.__Bag.__elems):
            return True
        return False

class BagF:
    def __init__(self):
        self.__elems = []
        self.__freq = []

    def add(self, e):
        if not(e in self.__elems):
            self.__elems.append(e)
            self.__freq.append(1)
        else:
            self.__freq[self.__elems.index(e)] += 1

    def remove(self, e):
        if not e in self.__elems:
            return False
        index = self.__elems.index(e)
        if self.__freq[index] == 1:
            self.__freq.pop(index)
            self.__elems.pop(index)
        else:
            self.__freq[index] -= 1

    def nrOccurrences(self, e):
        for i in range(len(self.__elems)):
            if self.__elems[i] == 0:
                return self.__freq
        return 0

    def size(self):
        sizeOf = 0
        for freq in self.__freq:
            sizeOf += freq
        return sizeOf

class BagFIterator:
    def __init__(self, b):
        self.__bag = b
        self.__index_array = 0
        self.__index_freq = 1

    def get_current(self):
        if not self.valid():
            raise ValueError
        return self.__bag.__BagF.__elems[self.__index_array]

    def next(self):
        if self.valid():
            if self.__bag.__BagF.__freq[self.__index_array] == self.__index_freq:
                self.__index_freq = 1
            else:
                self.__index_freq += 1
        else:
            raise ValueError

    def valid(self):
        if self.__index_array < len(self.__bag.__BagF.__elems):
            return True
        return False

