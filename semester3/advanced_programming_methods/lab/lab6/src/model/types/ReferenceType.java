package model.types;

import model.values.ReferenceValue;
import model.values.Value;

public class ReferenceType implements Type
{
    private final Type inner;
    public ReferenceType(Type inner) {this.inner = inner;}
    public Type getInner() {return this.inner;}

    @Override
    public boolean equals(Object another)
    {
        if (another instanceof ReferenceType)
            return inner.equals(((ReferenceType) another).getInner());
        return false;
    }

    @Override
    public String toString() {return "reference(" + inner.toString() + ")";}
    @Override
    public Value defaultValue() {return new ReferenceValue(0, inner);}

    @Override
    public Type deepCopy() {return new ReferenceType(this.inner);}
}
