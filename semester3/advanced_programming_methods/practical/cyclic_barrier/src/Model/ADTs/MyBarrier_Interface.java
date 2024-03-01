package Model.ADTs;

import java.util.Map;

public interface MyBarrier_Interface<T>
{

    Map<Integer,T> get_barrier_table();
    void set_barrier_table(Map<Integer,T> barrier_table);
    void put(Integer address, T value);
    int get_free_address();

}
