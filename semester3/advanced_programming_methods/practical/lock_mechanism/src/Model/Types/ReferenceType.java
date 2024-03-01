package Model.Types;

import Model.Values.ReferenceValue;
import Model.Values.Value;

public class ReferenceType implements Type

{

    Type inner;

    public ReferenceType(Type inner)
    {
        this.inner = inner;
    }

    @Override
    public Value default_value()
    {
        return new ReferenceValue(0,this.inner);
    }

    @Override
    public Type clone()
    {
        return new ReferenceType(this.inner);
    }


    public boolean equals(Object another)
    {
        if(another instanceof ReferenceType)
        {
            return this.inner.equals(((ReferenceType)another).get_inner());
        }
        else
        {
            return false;
        }
    }

    public Type get_inner()
    {
        return inner;
    }


    public String toString()
    {
        return "Ref( "+this.inner.toString()+" )";
    }
}
