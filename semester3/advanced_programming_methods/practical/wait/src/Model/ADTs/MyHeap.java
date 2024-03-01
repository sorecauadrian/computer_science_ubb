package Model.ADTs;


import java.util.HashMap;
import java.util.Map;

public class MyHeap<T> implements MyHeap_Interface<T>
{

    private HashMap<Integer,T> content;

    private int memory_address;
    public MyHeap()
    {
        this.content = new HashMap<Integer, T>();
        this.memory_address =0;
    }

    @Override
    public int allocate(Object content)
    {
        this.memory_address++;
        this.content.put(this.memory_address, (T) content);
        return this.memory_address;
    }

    @Override
    public T get(int address)
    {
        return this.content.get(address);
    }

    @Override
    public void put(int address, Object content)
    {
        this.content.put(address, (T) content);

    }

    public Map<Integer, T> get_content()
    {
        return content;
    }

    public void set_content(Map<Integer, T> content)
    {
        this.content = (HashMap)content;
    }

    @Override
    public T deallocate(int address)
    {
        return this.content.remove(address);
    }

    public String toString()
    {
        String result="{";
        for(HashMap.Entry<Integer,T> entry : this.content.entrySet())
        {
            result+=entry.getKey().toString()+"->"+entry.getValue().toString()+"\n";
        }
        result+=" }";

        return result;
    }


}
