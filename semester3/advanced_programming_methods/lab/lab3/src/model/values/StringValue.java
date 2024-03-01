package model.values;

import model.types.StringType;
import model.types.Type;

public class StringValue implements Value
{
    private final String value;

    public StringValue() {this.value = "";}
    public StringValue(String s) {this.value = s;}
    public String getValue() {return this.value;}

    @Override
    public Type getType() {return new StringType();}
    @Override
    public String toString() {return this.value;}
    @Override
    public boolean equals(Object another)
    {
        if (!(another instanceof StringValue that)) return false;
        if (this == another) return true;
        return this.getValue() == that.getValue();
    }
    @Override
    public Value deepCopy() {return new StringValue(this.value);}
}
