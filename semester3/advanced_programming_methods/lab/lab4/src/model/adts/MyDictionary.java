package model.adts;

import exceptions.ADTException;
import java.util.HashMap;
import java.util.Map;

public class MyDictionary<T, E> implements MyDictionaryInterface<T, E>
{
    Map<T, E> map;

    public MyDictionary() {this.map = new HashMap<>();}
    @Override
    public E lookup(T id) {return this.map.get(id);}
    @Override
    public boolean isVariableDefined(T id) {return this.map.containsKey(id);}
    @Override
    public Map<T, E> getContent() {return this.map;}
    @Override
    public void update(T id, E value) throws ADTException
    {
        if (!this.map.containsKey(id)) throw new ADTException("element does not exist");
        this.map.replace(id, value);
    }
    @Override
    public void add(T id, E value) throws ADTException
    {
        if (this.map.containsKey(id)) throw new ADTException("element already exists");
        this.map.put(id, value);
    }
    @Override
    public void remove(T id) throws ADTException
    {
        if (this.map.containsKey(id)) this.map.remove(id);
        else throw new ADTException("element does not exist");
    }
    @Override
    public String toString()
    {
        StringBuilder s = new StringBuilder();
        for (var elem: this.map.keySet())
            if (elem != null)
                s.append(elem).append(" -> ").append(this.map.get(elem).toString()).append('\n');
        return s.toString();
    }

    @Override
    public String keysToString()
    {
        StringBuilder s = new StringBuilder();
        for (var elem: this.map.keySet())
            if (elem != null)
                s.append(elem).append('\n');
        return s.toString();
    }
}
