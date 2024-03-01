package model.values;

import model.types.Type;

public interface Value
{
    Type getType();
    boolean equals(Object another);
    Value deepCopy();
}
