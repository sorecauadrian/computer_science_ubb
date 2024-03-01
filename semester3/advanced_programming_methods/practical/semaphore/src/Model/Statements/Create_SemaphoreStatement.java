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
import java.util.concurrent.locks.ReentrantLock;

public class Create_SemaphoreStatement implements Statement
{

    private String variable;
    private Expression expression;

    public Create_SemaphoreStatement(String variable, Expression expression1)
    {
        this.variable = variable;
        this.expression = expression1;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        ReentrantLock lock=new ReentrantLock();
        lock.lock();
        var symbol_table=state.get_symbol_table();
        var heap=state.get_heap();
        var semaphore_table=state.get_semaphore_table();
        Value expression_value=this.expression.evaluate(symbol_table,heap);

        if(expression_value.get_type().equals(new IntType()))
        {
            int actual_value=((IntValue)expression_value).get_value();
            int address=semaphore_table.get_address();
            semaphore_table.put(address,new Pair<>(actual_value,new ArrayList<>()));


            if(symbol_table.is_defined(variable) && symbol_table.lookup(variable).get_type().equals(new IntType()))
            {
                symbol_table.update(variable,new IntValue(address));
            }

            else
            {
                throw new Exception("Variable is not good in the Create Semaphore Statement!");
            }
            lock.unlock();

        }
        else
        {
            throw new Exception("Expression is of the wrong type in the Create Semaphore Statement!");
        }

        return null;

    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        var variable_type = type_environment.lookup(variable);

        if(variable_type.equals(new IntType()))
        {
            Type expression_type=this.expression.type_check(type_environment);

            if(expression_type.equals(new IntType()))
            {
                return type_environment;
            }
            else
            {
                throw new Exception("Expression is of the wrong type in the Create Semaphore Statement!");
            }
        }
        else
        {
            throw new Exception("Variable is not of type Int in the Create Semaphore Statement!");
        }
    }

    public String toString() {
        return "createSemaphore(" + variable.toString() + "," + expression.toString() + ")";
    }

}
