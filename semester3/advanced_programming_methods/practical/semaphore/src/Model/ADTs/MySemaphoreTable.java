package Model.ADTs;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class MySemaphoreTable<V> implements MySemaphoreTable_Interface<V>
{
    private int address=1;
    private Map<Integer,V> semaphore_table;


    public MySemaphoreTable(ConcurrentHashMap<Integer, V> semaphore_table)
    {
        this.semaphore_table = semaphore_table;
    }

    public MySemaphoreTable()
    {
        this.semaphore_table=new ConcurrentHashMap<>();
    }

    @Override
    public Map<Integer, V> get_semaphore_table()
    {
        return this.semaphore_table;
    }

    @Override
    public void set_semaphore_table(Map<Integer, V> semaphore_table)
    {
        this.semaphore_table=(ConcurrentHashMap<Integer, V>) semaphore_table;
    }

    @Override
    public void put(int address, V value)
    {
        this.semaphore_table.put(address, value);

    }

    @Override
    public int get_address()
    {
        address++;
        return address-1;
    }

    @Override
    public boolean is_defined(int address)
    {
        return this.semaphore_table.containsKey(address);
    }

    @Override
    public V lookup(int address)
    {
        return this.semaphore_table.get(address);
    }
}
