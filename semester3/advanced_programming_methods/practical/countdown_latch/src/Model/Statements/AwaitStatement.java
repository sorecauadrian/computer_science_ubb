package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import Model.Values.Value;

public class AwaitStatement implements Statement
{


    private String variable;

    public AwaitStatement(String variable)
    {
        this.variable = variable;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        if(state.get_symbol_table().is_defined(variable))
        {
            Value index=state.get_symbol_table().lookup(variable);
            int found_index=((IntValue)index).get_value();

            if(state.get_latch_table().is_defined(found_index))
            {
                if(state.get_latch_table().get_latch_table().get(found_index) != 0) //2 get_latch_table unul din state si unul sin ADT
                {
                    state.get_execution_stack().push(new AwaitStatement(variable));

                }
            }

            else
            {
                throw  new Exception("Index not in the Latch Table!");
            }
        }

        else
        {
            throw new Exception("Variable not in Symbol Table!");
        }

        return null;
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        var variable_type=type_environment.lookup(variable);


        if(variable_type.equals(new IntType()) )
        {
            return type_environment;
        }
        else
        {
            throw new Exception("Variable not of type INT in the Await Statement!");
        }
    }

    @Override
    public String toString() {
        return "await(" + variable + ")";
    }
}
