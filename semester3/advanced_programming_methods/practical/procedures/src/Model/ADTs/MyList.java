package Model.ADTs;

import Exceptions.MyException;

import java.util.List;


import java.util.ArrayList;


public class MyList<T> implements MyList_Interface<T>
{

    private List<T> list;

    public MyList()
    {
        this.list = new ArrayList<T>();
    }

    @Override
    public void add(T element)
    {
        this.list.add((T) element);


    }

    @Override
    public void remove(T element) throws Exception
    {

        if(!this.list.contains((T)element))
        {
            throw new MyException("Element does not exist!");
        }

    }

    @Override
    public T get_element(int index) throws Exception
    {
        if(index<0 || index>=this.list.size())
        {
            throw new MyException("Invalid index!");
        }
        return this.list.get(index);
    }

    @Override
    public int size()
    {
        return this.list.size();
    }


    @Override
    public List get_content()
    {
        return this.list;
    }


    public String toString()
    {
        String result="{ ";

        for(T element:this.list)
        {
            result+=element.toString()+" ";
        }
        result+=" }\n";
        return result;

    }
}
