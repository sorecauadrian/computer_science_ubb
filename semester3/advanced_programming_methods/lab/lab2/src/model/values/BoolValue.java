package model.values;

import model.types.BoolType;
import model.types.Type;

public class BoolValue implements Value
{
    private final boolean value;
    public BoolValue(boolean v) {this.value = v;}
    public boolean getValue() {return this.value;}

    @Override
    public Type getType() {return new BoolType();}
    @Override
    public String toString() {return Boolean.toString(this.getValue());}
    @Override
    public boolean equals(Object another)
    {
        if (!(another instanceof BoolValue that)) return false;
        if (this == another) return true;
        return this.getValue() == that.getValue();
    }
}
