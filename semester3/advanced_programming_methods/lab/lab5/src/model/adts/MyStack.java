package model.adts;

import exceptions.ADTException;
import java.util.ListIterator;
import java.util.Stack;

public class MyStack<T> implements MyStackInterface<T>
{
    private final Stack<T> stack;

    public MyStack() {this.stack = new Stack<>();}

    @Override
    public T pop() throws ADTException
    {
        if (this.stack.isEmpty())
            throw new ADTException("stack is empty");
        return this.stack.pop();
    }

    @Override
    public void push(T v) {this.stack.push(v);}

    @Override
    public boolean isEmpty() {return this.stack.isEmpty();}

    @Override
    public String toString()
    {
        StringBuilder s = new StringBuilder();
        ListIterator<T> stackIterator = stack.listIterator(stack.size());
        while (stackIterator.hasPrevious())
            s.append(stackIterator.previous().toString()).append('\n');
        return s.toString();
    }
}
