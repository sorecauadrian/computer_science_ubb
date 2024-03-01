package model.adts;

import exceptions.ADTException;
import exceptions.InterpreterException;

import java.util.Map;

public interface MyDictionaryInterface<T, E>
{
    public E lookup(T id);
    boolean isVariableDefined(T id);
    void update(T id, E value) throws ADTException;
    void add(T id, E value) throws ADTException;
    void remove(T id, E value) throws ADTException;
    Map<T, E> getContent();
}
