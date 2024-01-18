package model.adts;

import exceptions.ADTException;

public interface MyStackInterface<T>
{
    T pop() throws ADTException;
    void push(T v);
    boolean isEmpty();

}
