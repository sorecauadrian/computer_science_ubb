package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Exceptions.*;
import Model.ProgramState.*;
import Model.Types.StringType;
import Model.Types.Type;
import Model.Values.StringValue;
import Model.Values.Value;

import java.io.BufferedReader;

public class Close_FileStatement implements Statement
{


    private Expression expression;

    public Close_FileStatement(Expression expression)
    {
        this.expression=expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        Value evaluation_value;
        evaluation_value=this.expression.evaluate(state.get_symbol_table(),state.get_heap());

        if(evaluation_value.get_type().equals(new StringType()))
        {
            StringValue expression_value_wrapper=(StringValue)evaluation_value;
            String expression_value=expression_value_wrapper.get_value();

            if(state.get_file_table().is_defined(expression_value))
            {
                BufferedReader associated_file_descriptor= state.get_file_table().lookup(expression_value);
                associated_file_descriptor.close();
                state.get_file_table().delete(expression_value);

            }
            else
            {
                throw new MyException("Filename does not exist!");
            }
        }
        else
        {
            throw new MyException("Expressions evaluation result is not a string!");
        }
        return null;
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception
    {
        Type expression_type= expression.type_check(type_environment);

        if(expression_type.equals(new StringType()))
        {
            return  type_environment;
        }
        else
        {
            throw new Exception("Expression type of the close file statement is not a string!");
        }
    }

    public String toString()
    {
        return "close(" + expression.toString() + ")";
    }
}
