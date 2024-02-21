package Model.ADTs;

import Exceptions.MyException;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class MyLockTable<Key,Value> implements MyLockTable_Interface<Key,Value>
{

    private ConcurrentHashMap<Key,Value> lock_table;
    private int address=0;

    public MyLockTable(ConcurrentHashMap<Key, Value> lock_table)
    {
        this.lock_table = lock_table;

    }

    public MyLockTable()
    {
        this.lock_table=new ConcurrentHashMap<>();
    }

    @Override
    public Value get(Key key) {
        return this.lock_table.get(key);
    }


    @Override
    public Value lookup(Key key) throws Exception
    {
        if(!this.lock_table.containsKey(key))
        {
            throw new MyException("Key does not exist!");
        }
        return this.lock_table.get(key);
    }

    @Override
    public void put(Key key, Value value)
    {
        lock_table.put(key,value);
    }

    @Override
    public void replace(Key key, Value value)
    {
        lock_table.replace(key, value);
    }
    @Override
    public int get_free_address()
    {
        this.address++;
        return address;
    }

    @Override
    public Map<Key,Value> get_lock_table()
    {
        return this.lock_table;
    }

    @Override
    public void set_lock_table(Map<Key, Value> latch_table)
    {
        this.lock_table= (ConcurrentHashMap<Key, Value>) latch_table;
    }

    @Override
    public boolean is_defined(Key key)
    {
        return lock_table.containsKey(key);
    }


    @Override
    public Map<Key, Value> get_content() {
        return this.lock_table;
    }
}
