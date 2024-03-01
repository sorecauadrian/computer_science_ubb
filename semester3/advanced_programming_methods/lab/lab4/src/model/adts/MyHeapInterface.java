package model.adts;

import java.util.Map;

public interface MyHeapInterface<T>
{
    int allocate(T value);
    T get(int address);
    void put(int address, T value);
    Map<Integer, T> getContent();
    boolean exists(int address);
    void setContent(Map<Integer, T> map);
}
