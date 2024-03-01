package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.ReferenceType;
import Model.Types.Type;
import Model.Values.ReferenceValue;
import Model.Values.Value;

//heap allocation statement
public class NewStatement implements Statement
{

    private String variable_name;
    private Expression expression;

    public NewStatement(String variable_name, Expression expression)
    {
        this.variable_name = variable_name;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        if(state.get_symbol_table().is_defined(variable_name))
        {
            Value value=state.get_symbol_table().lookup(variable_name);
            if (value instanceof ReferenceValue)
            {
                Value expression_value=expression.evaluate(state.get_symbol_table(),state.get_heap());
                if(expression_value.get_type().equals(((ReferenceValue)value).get_location_type()))
                {
                    int location=state.get_heap().allocate(expression_value);
                    state.get_symbol_table().update(variable_name,new ReferenceValue(location,expression_value.get_type()));
                }
                else
                {
                    throw new MyException("Types are not equal!");
                }
            }
            else
            {
                throw new MyException("Value's Type is not ReferenceType!");
            }
        }
        else
        {
            throw new MyException("Variable is not defined!");
        }
        return null;

    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        Type type_variable=type_environment.lookup(variable_name);
        Type type_expression=expression.type_check(type_environment);

        if(type_variable.equals(new ReferenceType(type_expression)))
        {
            return type_environment;
        }
        else
        {
            throw new Exception("Different types in the New Statement!");
        }
    }

    public String toString()
    {
        return "new(" + variable_name + ", " + expression.toString() + ")";
    }

}
