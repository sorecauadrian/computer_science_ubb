package Model.ADTs;

import java.util.Map;

public interface MyLatchTable_Interface<Key,Value>
{
    void put(Key key, Value value);
    Map<Key,Value> get_latch_table();
    void set_latch_table(Map<Key,Value> latch_table);
    boolean is_defined(Key key);
    int get_free_address();
    public Map<Key, Value> get_content();
}
