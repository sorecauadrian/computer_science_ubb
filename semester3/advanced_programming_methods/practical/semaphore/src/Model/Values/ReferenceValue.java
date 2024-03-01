package Model.Values;

import Model.Types.ReferenceType;
import Model.Types.Type;

public class ReferenceValue implements Value
{

    int address;
    Type location_type;



    public ReferenceValue(int address, Type location_type)
    {
        this.address = address;
        this.location_type = location_type;
    }

    @Override
    public Type get_type()
    {
        return new ReferenceType(this.location_type);
    }

    @Override
    public Value clone()
    {
        return new ReferenceValue(this.address,this.location_type);
    }

    public int get_address()
    {
        return address;
    }

    public Type get_location_type()
    {
        return location_type;
    }

    public String toString()
    {
        return "( " + this.address + ", " + location_type.toString()+ " )";
    }
}
