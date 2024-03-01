package model.values;

import model.types.ReferenceType;
import model.types.Type;

public class ReferenceValue implements Value
{
    private final int address;
    private final Type type;

    public ReferenceValue(int address, Type type)
    {
        this.address = address;
        this.type = type;
    }
    public int getAddress() {return this.address;}

    @Override
    public Type getType() {return new ReferenceType(type);}

    @Override
    public boolean equals(Object another)
    {
        if (!(another instanceof ReferenceValue that)) return false;
        if (this == another) return true;
        return this.getAddress() == that.getAddress();
    }

    @Override
    public String toString() {return "(" + this.address + ", " + this.type + ")";}

    @Override
    public Value deepCopy() {return new ReferenceValue(this.address, this.type);}
}
