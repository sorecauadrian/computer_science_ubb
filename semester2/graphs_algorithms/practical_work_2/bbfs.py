def bbfs(self, vertex1: int, vertex2: int):
    """
    :param vertex1: the starting vertex
    :param vertex2: the ending vertex
    """
    # set of visited nodes to prevent loops
    visited = set()
    queue = Queue()

    # add vertex1 to the queue and visited list
    visited.add(vertex2)
    queue.put(vertex2)

    # vertex1 has no child
    child = dict()
    child[vertex2] = None

    # bbfs
    path_found = False
    while not queue.empty():
        # getting the first element on the queue
        current_node = queue.get()

        # if not, we're going through all the predecessors of the current node
        for next_node in self.predecessors[current_node]:
            # and taking only those that are not visited
            if next_node not in visited:
                # then adding them to the queue, setting their parent and marking them as visited
                queue.put(next_node)
                child[next_node] = current_node
                visited.add(next_node)
                if next_node == vertex1:
                    path_found = True
                    break

    # path reconstruction
    path = []
    if path_found:
        path.append(vertex1)
        while child[vertex1] is not None:
            path.append(child[vertex1])
            vertex1 = child[vertex1]

    if len(path) != 0:
        print("length: " + str(len(path) - 1))
        print(path)
    else:
        print("there's no path between those vertices!")