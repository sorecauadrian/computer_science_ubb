package Model.ADTs;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class MyBarrier<T> implements MyBarrier_Interface<T>
{

    private ConcurrentHashMap<Integer,T> barrier_table;
    private int address=1;

    public MyBarrier(ConcurrentHashMap<Integer, T> barrier_table)
    {
        this.barrier_table = barrier_table;
    }

    public MyBarrier()
    {
        this.barrier_table=new ConcurrentHashMap<>();
    }

    @Override
    public Map get_barrier_table() {
        return this.barrier_table;
    }

    @Override
    public void put(Integer address, Object value)
    {
        barrier_table.put(address,(T) value);
    }

    @Override
    public int get_free_address()
    {
        this.address++;
        return this.address-1;
    }

    @Override
    public void set_barrier_table(Map barrier_table)
    {

        barrier_table=(ConcurrentHashMap<Integer,T>) barrier_table;

    }
}
