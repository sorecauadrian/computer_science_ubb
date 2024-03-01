package Model.Values;

import Model.Types.Type;


public interface Value
{
    Type get_type();

    Value clone();


}
