package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.ReferenceType;
import Model.Types.Type;
import Model.Values.ReferenceValue;
import Model.Values.Value;

public class Heap_WriteStatement implements Statement
{
    private String variable_name;
    private Expression expression;

    public Heap_WriteStatement(String variable_name, Expression expression)
    {
        this.variable_name = variable_name;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
       if(state.get_symbol_table().is_defined(this.variable_name))
       {
           Value value=state.get_symbol_table().lookup(this.variable_name);

           if(value instanceof ReferenceValue)
           {
                int address=((ReferenceValue)value).get_address();

                if(state.get_heap().get(address)!=null)
                {
                    Value evaluation_value=this.expression.evaluate(state.get_symbol_table(),state.get_heap());

                    if(evaluation_value.get_type().equals(((ReferenceValue)value).get_location_type()))
                    {
                        state.get_heap().put(address,evaluation_value);
                    }
                    else
                    {
                        throw new MyException("Incompatible types!");
                    }

                }
                else
                {
                    throw new MyException("No mapping for this address in the heap!");
                }
           }
           else
           {
               throw new MyException("Value is not of type Reference Type!");

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
            throw new Exception("Types do not match in the Heap Write statement!");
        }
    }

    public String toString()
    {
        return "wH(" + variable_name+ ", " + expression.toString() + ")";
    }

}
