package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import javafx.util.Pair;

import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

public class AcquireStatement implements Statement
{



    private String variable;

    public AcquireStatement(String  variable)
    {
        this.variable = variable;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        ReentrantLock lock=new ReentrantLock();
        lock.lock();
        var symbol_table=state.get_symbol_table();
        var heap=state.get_heap();
        var semaphore_table=state.get_semaphore_table();

        if(symbol_table.is_defined(this.variable))
        {
            int found_index=((IntValue)symbol_table.lookup(this.variable)).get_value();
            if(semaphore_table.is_defined(found_index))
            {
                var pair=semaphore_table.get_semaphore_table().get(found_index);
                List<Integer> list=pair.getValue();
                int NR=pair.getKey();
                int NL=list.size();

                if(NR>NL)
                {
                    if (!list.contains(state.get_id()))
                    {
                        list.add(state.get_id());
                    }

                }
                else
                {
                    state.get_execution_stack().push(new AcquireStatement(this.variable));
                }


            }
            else
            {
                throw new Exception("Index not in the Semaphore Table in Acquire Statement!");
            }

        }
        else
        {
            throw new Exception("Variable is not defined Acquire Statement!");
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
        else
        {
            throw new Exception("Variable is not of type Int in the Acquire Statement!");
        }
    }

    public String toString() {
        return "acquire(" + this.variable.toString() + ")";
    }
}
