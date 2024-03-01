package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import javafx.util.Pair;

import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ReleaseStatement implements Statement
{
    private String variable;


    public ReleaseStatement(String variable) {
        this.variable = variable;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        ReentrantLock lock=new ReentrantLock();

        lock.lock();

        int found_index=((IntValue)state.get_symbol_table().lookup(this.variable)).get_value();
        var semaphore_table=state.get_semaphore_table();

        var pair=semaphore_table.get_semaphore_table().get(found_index);


        var list = pair.getValue();
        if(list.contains(state.get_id()))
        {
            list.remove(Integer.valueOf(state.get_id()));    //had to give the parameter like this else the remove function will think that id is an index


        }
        lock.unlock();
        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        var variable_type = type_environment.lookup(variable);
        if(variable_type.equals(new IntType()))
        {
            return type_environment;
        }
        else throw new Exception("Variable is not of type Int in Release Statement!");
    }

    public String toString() {
        return "release(" + this.variable.toString() + ")";
    }


}
