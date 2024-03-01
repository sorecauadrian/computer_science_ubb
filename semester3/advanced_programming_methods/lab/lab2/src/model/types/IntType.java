package model.types;

import model.values.Value;
import model.values.IntValue;

public class IntType implements Type
{
    @Override
    public Value defaultValue() {return new IntValue(0);}
    @Override
    public boolean equals(Object another) {return another instanceof IntType;}
    @Override
    public String toString() {return "int";}
}
