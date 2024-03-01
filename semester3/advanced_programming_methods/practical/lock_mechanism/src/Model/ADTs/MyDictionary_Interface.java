package Model.ADTs;

import java.util.Map;
import java.util.List;

public interface MyDictionary_Interface<Key,Value>
{
    Value lookup(Key key) throws Exception;
    boolean is_defined(Key key);
    void update(Key key,Value value);
    void delete(Key key) throws Exception;
    void add(Key key, Value value);
    Map<Key,Value> get_content();
    public void clear_all();
    MyDictionary_Interface<Key,Value> clone();


    @Override
    String toString();


}
