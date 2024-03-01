package Model.Types;


import Model.Values.IntValue;

public class IntType implements Type
{


    public boolean equals(Object another)
    {
        if (another instanceof IntType)
        {
            return true;
        }
        else
        {
            return false;
        }

    }



    @Override
    public IntValue default_value()
    {
        return new IntValue(0);
    }

    @Override
    public Type clone()
    {
        return new IntType();
    }

    public String toString()
    {
        return  "int";
    }
}
