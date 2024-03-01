package model.adts;

import exceptions.ADTException;

import java.util.Map;

public interface MyDictionaryInterface<T, E>
{
    E lookup(T id);
    boolean isVariableDefined(T id);
    Map<T, E> getContent();
    void update(T id, E value) throws ADTException;
    void add(T id, E value) throws ADTException;
    void remove(T id) throws ADTException;
    String keysToString();
}
