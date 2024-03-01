package Model.Values;

import Model.Types.*;

public class IntValue implements Value
{
    private int value;

    public IntValue(int value)
    {
        this.value=value;
    }




    @Override
    public Type get_type()
    {
        return new IntType();
    }


    public int get_value()
    {
        return this.value;
    }

    @Override
    public Value clone()
    {
        return new IntValue(this.value);
    }

    public String toString()
    {
        return String.valueOf(this.value);
    }
}
