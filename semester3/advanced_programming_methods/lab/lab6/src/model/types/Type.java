package model.types;

import model.values.Value;
public interface Type
{
    Value defaultValue();
    boolean equals(Object another);
    Type deepCopy();
}
