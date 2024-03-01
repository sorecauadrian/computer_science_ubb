package model.adts;

import java.util.HashMap;
import java.util.Map;

public class MyHeap<T> implements MyHeapInterface<T>
{
    int freeValue;
    private Map<Integer, T> heap;
    public MyHeap()
    {
        this.heap = new HashMap<>();
        this.freeValue = 0;
    }

    @Override
    public int allocate(T value)
    {
        this.freeValue++;
        this.heap.put(this.freeValue, value);
        return this.freeValue;
    }
    @Override
    public T get(int address) {return this.heap.get(address);}
    @Override
    public void put(int address, T value) {this.heap.put(address, value);}
    @Override
    public Map<Integer, T> getContent() {return this.heap;}
    @Override
    public String toString()
    {
        StringBuilder s = new StringBuilder();
        for (var elem : this.heap.keySet())
            if (elem != null)
                s.append(elem).append(" -> ").append(this.heap.get(elem).toString()).append('\n');
        return s.toString();
    }
    @Override
    public boolean exists(int address) {return heap.containsKey(address);}
    @Override
    public void setContent(Map<Integer, T> map) {this.heap = map;}
}
