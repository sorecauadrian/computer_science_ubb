package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import Model.Values.Value;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

public class New_BarrierStatement implements Statement
{


    private String variable;
    private Expression expression;

    public New_BarrierStatement(String variable, Expression expression)
    {
        this.variable = variable;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        ReentrantLock lock=new ReentrantLock();
        lock.lock();
        Value number=expression.evaluate(state.get_symbol_table(),state.get_heap());
        if(!number.get_type().equals(new IntType()))
        {
            throw new Exception("Expression is not of Int Type in the New Barrier Statement");
        }
        int number_value=((IntValue)number).get_value();

        Pair<Integer, List<Integer>> pair=new Pair<Integer,List<Integer>>(number_value,new ArrayList<Integer>());
        int address=state.get_barrier_table().get_free_address();
        state.get_barrier_table().put(address,pair);

        if(state.get_symbol_table().is_defined(this.variable))
        {
            state.get_symbol_table().update(variable, new IntValue(address));

        }
        else
        {
            throw new Exception("Variable is not defined in the Symbol Table at New Barrier Statement!");
        }
        lock.unlock();

        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        Type expression_type=expression.type_check(type_environment);
        Type variable_type=type_environment.lookup(this.variable);


        if(expression_type.equals(new IntType()) && variable_type.equals(new IntType()))
        {
            return type_environment;
        }
        throw new Exception("Types are not good in the New Barrier Statement!");
    }

    @Override
    public String toString()
    {
        return "newBarrier(" + this.variable + "," + this.expression.toString() + ")";
    }
}
