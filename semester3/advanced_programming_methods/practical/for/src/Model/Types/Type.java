package Model.Types;
import Model.Values.Value;


public interface Type
{
    Value default_value();
    Type clone();

}
