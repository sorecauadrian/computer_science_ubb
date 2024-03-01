package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import Model.Values.Value;

import java.util.concurrent.locks.ReentrantLock;

public class Count_DownStatement implements Statement
{



    private String variable;

    public Count_DownStatement(String variable)
    {
        this.variable = variable;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        ReentrantLock lock = new ReentrantLock();
        Value index = state.get_symbol_table().lookup(variable);
        int found_index=((IntValue) index).get_value();

        if(state.get_latch_table().get_latch_table().get(found_index)>-1)
        {
            state.get_latch_table().get_latch_table().put(found_index,state.get_latch_table().get_latch_table().get(found_index)-1);
            state.get_output().add(new IntValue(state.get_id()));
        }

        lock.unlock();
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
        return "countDown(" + variable + ")";
    }
}
