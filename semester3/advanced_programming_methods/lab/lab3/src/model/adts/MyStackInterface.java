package model.adts;

import exceptions.ADTException;
import java.util.List;

public interface MyStackInterface<T>
{
    T pop() throws ADTException;
    void push(T v);
    T top() throws ADTException;
    int size();
    boolean isEmpty();
    List<T> getContent();
}
