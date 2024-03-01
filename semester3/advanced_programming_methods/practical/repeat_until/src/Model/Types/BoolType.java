package Model.Types;

import Model.Values.BoolValue;
import Model.Values.Value;

public class BoolType implements Type
{
    @Override
    public boolean equals(Object another)
    {
        if(another instanceof BoolType)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    @Override
    public BoolValue default_value()
    {
        return new BoolValue(false);
    }

    @Override
    public Type clone()
    {
        return new BoolType();
    }

    public String toString()
    {
        return "bool";
    }
}
