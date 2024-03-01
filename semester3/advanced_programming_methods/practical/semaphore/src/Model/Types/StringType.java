package Model.Types;

import Model.Values.*;

public class StringType implements Type
{


    @Override
    public boolean equals(Object second)
    {
        if (second instanceof StringType)
        {
            return true;
        }
        else
        {
            return false;
        }
    }




    @Override
    public Value default_value()
    {
        return new StringValue("");
    }

    @Override
    public Type clone()
    {
        return new StringType();
    }

    public String toString()
    {
        return "string ";
    }

}
