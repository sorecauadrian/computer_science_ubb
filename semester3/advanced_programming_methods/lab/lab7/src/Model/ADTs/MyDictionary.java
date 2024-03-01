package Model.ADTs;

import Exceptions.MyException;
import Model.Values.Value;

import java.util.HashMap;
import java.util.Map;


public class MyDictionary<Key,Value> implements MyDictionary_Interface<Key,Value>
{

    private HashMap<Key,Value> dictionary;

    public MyDictionary()
    {
        this.dictionary= new HashMap<Key,Value>();
    }



    @Override
    public Value lookup(Key key) throws Exception
    {
        if(!this.dictionary.containsKey((Key)key))
        {
            throw new MyException("Key does not exist!");
        }
        return this.dictionary.get((Key)key);
    }

    @Override
    public boolean is_defined(Key key)
    {
        return this.dictionary.containsKey((Key)key);
    }

    @Override
    public void update(Key key, Value value)
    {
        this.dictionary.put((Key)key,(Value)value);

    }

    @Override
    public void delete(Key key) throws Exception
    {
        if(!this.dictionary.containsKey((Key)key))
        {
            throw new MyException("Key does not exist!");
        }
        this.dictionary.remove((Key)key);

    }

    @Override
    public void add(Key key, Value value)
    {
        this.dictionary.put((Key)key,(Value)value);
    }

    @Override
    public Map<Key,Value> get_content()
    {
        return this.dictionary;
    }

    @Override
    public void clear_all()
    {
     this.dictionary=new HashMap<Key,Value>();
    }

    @Override
    public MyDictionary_Interface<Key, Value> clone()
    {
        MyDictionary_Interface<Key,Value> clone_dictionary=new MyDictionary<>();

        for(Key key: dictionary.keySet())
        {
            clone_dictionary.update(key,dictionary.get(key));
        }
        return clone_dictionary;
    }

    public String toString()
    {
        String result="{ ";
        for(Key key: this.dictionary.keySet())
        {
            result+=key.toString() + "->" + this.dictionary.get(key).toString() + "; ";
        }
        result+="}\n";

        return result;

    }
}
