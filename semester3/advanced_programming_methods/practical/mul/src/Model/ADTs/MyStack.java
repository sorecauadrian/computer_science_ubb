package Model.ADTs;


import java.util.Stack;
import java.util.List;

public class MyStack<T> implements MyStack_Interface<T>
{
    private Stack<T> stack;

    public MyStack()
    {
        this.stack=new Stack<T>();
    }

    @Override
    public T pop() throws Exception
    {
        return this.stack.pop();
    }

    @Override
    public void push(T value)
    {
        this.stack.push((T)value);

    }

    @Override
    public boolean is_empty()
    {
        return this.stack.isEmpty();
    }

    @Override
    public List<T> get_values()
    {
        return this.stack.subList(0,this.stack.size());
    }

    @Override
    public void clear_all()
    {
        this.stack=new Stack<T>();
    }


    public String toString()
    {
        String result="";

        for(T element:this.stack)
        {
           result=element.toString() + " | " + result;
            // result+= element.toString()+" |";
        }
        result="{ " + result;
        result+=" }\n";

        return result;

    }





}
