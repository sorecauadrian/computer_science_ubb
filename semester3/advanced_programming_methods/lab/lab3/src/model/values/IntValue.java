package model.values;

import model.types.IntType;
import model.types.Type;

public class IntValue implements Value
{
    private final int value;
    public IntValue() {this.value = 0;}
    public IntValue(int v) {this.value = v;}
    public int getValue() {return this.value;}

    @Override
    public Type getType() {return new IntType();}
    @Override
    public String toString() {return Integer.toString(this.getValue());}
    @Override
    public boolean equals(Object another)
    {
        if (!(another instanceof IntValue that)) return false;
        if (this == another) return true;
        return this.getValue() == that.getValue();
    }
    @Override
    public Value deepCopy() {return new IntValue(this.value);}
}

