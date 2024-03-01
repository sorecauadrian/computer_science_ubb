package Model.ADTs;

public class MyPair<T,U> implements MyPair_Interface
{

    private T first;
    private U second;

    public MyPair(T first,U second)
    {
        this.first=first;
        this.second=second;
    }


    @Override
    public T get_first()
    {
        return this.first;
    }

    @Override
    public U get_second()
    {
        return this.second;
    }
}
