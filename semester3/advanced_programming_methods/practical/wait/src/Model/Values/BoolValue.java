package Model.Values;

import Model.Types.*;

public class BoolValue implements Value
{
    private boolean value;

    public BoolValue(boolean value)
    {
        this.value=value;
    }

    @Override
    public Type get_type()
    {
        return new BoolType();
    }

    @Override
    public Value clone()
    {
        return new BoolValue(this.value);
    }

    public Boolean get_value()
    {
        return this.value;
    }

    public String toString()
    {
        return String.valueOf(this.value);
    }
}
