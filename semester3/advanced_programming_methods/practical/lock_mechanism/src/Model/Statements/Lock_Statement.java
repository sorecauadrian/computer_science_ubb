package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;

public class Lock_Statement implements Statement
{
    String variable;

    public Lock_Statement(String variable)
    {
        this.variable = variable;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        var symbol_table=state.get_symbol_table();
        var lock_table=state.get_lock_table();

        if(!symbol_table.is_defined(this.variable))
        {
            throw new Exception("Variable not declared in the Lock Statement!");
        }
        if(!symbol_table.lookup(this.variable).get_type().equals(new IntType()))
        {
            throw new Exception("Variable not of Integer Type in the Lock Statement!");
        }

        int foundIndex=((IntValue)symbol_table.lookup(this.variable)).get_value();

        if(lock_table.lookup(foundIndex) == -1)
        {
            lock_table.replace(foundIndex,state.get_id());
        }
        else
        {
            state.get_execution_stack().push(new Lock_Statement(this.variable));
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
            throw new Exception("Variable not of type INT!");
        }

    }

    @Override
    public String toString() {
        return "lock(" + variable + ")";
    }
}
