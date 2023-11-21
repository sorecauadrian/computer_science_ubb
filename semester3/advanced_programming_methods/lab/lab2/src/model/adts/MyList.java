package model.adts;

import java.util.LinkedList;
import java.util.List;

public class MyList<T> implements MyListInterface<T>
{
    private final List<T> list;

    public MyList() {this.list = new LinkedList<>();}

    @Override
    public String toString()
    {
        StringBuilder s = new StringBuilder();
        for (T elem : list)
            if (elem != null)
            {
                s.append(elem);
                s.append('\n');
            }
        return s.toString();
    }

    @Override
    public void addElement(T element) {this.list.add(element);}
    @Override
    public List<T> getContent() {return this.list;}
}
