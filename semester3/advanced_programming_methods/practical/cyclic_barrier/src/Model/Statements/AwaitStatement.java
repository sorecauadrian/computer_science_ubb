package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import Model.Values.Value;
import javafx.util.Pair;

import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

public class AwaitStatement implements Statement
{

    private Expression variable;

    public AwaitStatement(Expression variable)
    {
        this.variable = variable;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        ReentrantLock lock=new ReentrantLock();
        lock.lock();

        Value found_value=state.get_symbol_table().lookup(this.variable.toString());

        if(!found_value.get_type().equals(new IntType()))
        {
            throw new Exception("Variable is not of type Int in the Await Statement!");
        }

        int found_index=((IntValue)found_value).get_value();
        if(!state.get_barrier_table().get_barrier_table().containsKey(found_index))
        {
            throw new Exception("No index found in the barrier table!");
        }

        Pair<Integer, List<Integer>> pair=state.get_barrier_table().get_barrier_table().get(found_index);

        int NL=pair.getValue().size();
        int N1=pair.getKey();

        List<Integer> threads=pair.getValue();

        if(N1>NL)
        {
            if(pair.getValue().contains(state.get_id()))
            {
                state.get_execution_stack().push(new AwaitStatement(this.variable));
            }
            else
            {
                threads.add(state.get_id());
                state.get_barrier_table().get_barrier_table().put(found_index,new Pair(N1,threads));
            }
        }


        lock.unlock();

        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception
    {
        Type expression_type = this.variable.type_check(type_environment);
        if(expression_type.equals(new IntType()))
            return type_environment;
        throw new Exception("Variable not of type Int in the Await Statement!");
    }

    public String toString()
    {
        return "await(" + this.variable.toString() + ")";
    }
}
