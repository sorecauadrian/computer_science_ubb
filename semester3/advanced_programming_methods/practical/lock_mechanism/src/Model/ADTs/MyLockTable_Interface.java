package Model.ADTs;

import java.util.Map;

public interface MyLockTable_Interface<Key,Value>
{
    public Value get(Key key);

    Value lookup(Key key) throws Exception;

    public void put(Key key, Value value);

    public void replace(Key key, Value value);
    int get_free_address();

    Map<Key, Value> get_lock_table();

    void set_lock_table(Map<Key, Value> latch_table);

    boolean is_defined(Key key);

    public Map<Key, Value> get_content();

}
