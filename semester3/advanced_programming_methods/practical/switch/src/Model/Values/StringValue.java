package Model.Values;

import Model.Types.Type;
import Model.Types.StringType;

public class StringValue implements Value
{

    private String value;

    public StringValue(String value)
    {
        this.value=value;

    }

    public String get_value()
    {
        return this.value;
    }

    @Override
    public Type get_type()
    {
        return new StringType();
    }

    @Override
    public Value clone()
    {
        return new StringValue(this.value);
    }


    public String toString()
    {
        return "\"" + value + "\"";
    }
}
