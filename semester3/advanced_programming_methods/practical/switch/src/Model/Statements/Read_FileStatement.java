package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Exceptions.*;
import Model.ProgramState.*;
import Model.Types.IntType;
import Model.Types.StringType;
import Model.Types.Type;
import Model.Values.StringValue;
import Model.Values.Value;
import Model.Values.IntValue;

import java.io.BufferedReader;
import java.io.FileReader;

public class Read_FileStatement implements Statement
{

    private Expression expression;
    private String variable_name;


    public Read_FileStatement(Expression expression, String variable_name)
    {

        this.expression=expression;
        this.variable_name=variable_name;

    }


    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
       if(state.get_symbol_table().is_defined(variable_name))
       {
           if(state.get_symbol_table().lookup(variable_name).get_type().equals(new IntType()))
           {
                Value evaluation_value=this.expression.evaluate(state.get_symbol_table(),state.get_heap());

                if(evaluation_value.get_type().equals(new StringType()))
                {
                    StringValue expression_value_wrapper=(StringValue)evaluation_value;
                    String expression_value=expression_value_wrapper.get_value();

                    if(state.get_file_table().is_defined(expression_value))
                    {
                        BufferedReader file_descriptor=state.get_file_table().lookup(expression_value);
                        String line=file_descriptor.readLine();
                        IntValue read_value;

                        if(line==null)
                        {
                            read_value=new IntValue(0);
                        }
                        else
                        {
                            read_value=new IntValue(Integer.parseInt(line));
                        }
                        state.get_symbol_table().update(variable_name,read_value);

                    }
                    else
                    {
                        throw new MyException("File not existent in the File Table!");
                    }

                }
                else
                {
                    throw new MyException("Expression's value is not a string!");
                }

            }
            else
            {
                throw new MyException("Variable's type is not int!");
            }

        }
        else
        {
            throw new MyException("Variable's name is not defined in the Symbol Table!");
        }
        return null;

    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        Type type_variable=type_environment.lookup(variable_name);
        Type type_expression=expression.type_check(type_environment);

        if(type_variable.equals(new IntType()))
        {
            if(type_expression.equals(new StringType()))
            {
                return type_environment;
            }
            else
            {
                throw new Exception("Expression's value is not a string!");
            }

        }
        else
        {
            throw new Exception("Variable is not of type int!");
        }
    }

    public String toString() {
        return "read("+expression.toString() + ", " + variable_name + ")";
    }
}
