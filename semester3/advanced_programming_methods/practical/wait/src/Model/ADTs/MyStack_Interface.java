package Model.ADTs;

import java.util.Stack;
import java.util.List;

public interface MyStack_Interface<T>
{
    T pop() throws Exception;
    void push(T value);
    boolean is_empty();

    List<T> get_values();

    void clear_all();

    @Override
    String toString();



}
