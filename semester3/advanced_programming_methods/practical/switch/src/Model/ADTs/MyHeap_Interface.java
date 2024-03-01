package Model.ADTs;

import java.util.Map;

public interface MyHeap_Interface<T>
{
    int allocate(T content);
    T get(int address);
    void put(int address,T content);
    T deallocate(int address);
    Map<Integer, T> get_content();
    void set_content(Map<Integer, T> content);



}
