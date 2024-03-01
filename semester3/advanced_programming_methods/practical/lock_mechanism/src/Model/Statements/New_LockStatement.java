package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class New_LockStatement implements Statement{

    String variable;

    public New_LockStatement(String variable)
    {
        this.variable = variable;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        Lock lock=new ReentrantLock();
        lock.lock();
        int getFreeAddress = state.get_lock_table().get_free_address();
        state.get_lock_table().put(getFreeAddress, -1);
        if(state.get_symbol_table().is_defined(this.variable))
        {
            Type variableType=state.get_symbol_table().lookup(this.variable).get_type();
            if(variableType.equals(new IntType()))
            {
                state.get_symbol_table().update(this.variable,new IntValue(getFreeAddress));
            }
            else
            {
                throw new Exception("Variable is not of type INT in the New Lock Statement!");
            }
        }
        else
        {
            throw new Exception("Variable is not defined in the Symbol Table!");
        }
        lock.unlock();

        return null;
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> typeEnvironment) throws Exception
    {
        var variableType=typeEnvironment.lookup(variable);


        if(variableType.equals(new IntType()) )
        {
            return typeEnvironment;
        }
        else
        {
            throw new Exception("Variable not of type INT!");
        }

    }

    @Override
    public String toString()
    {
        return "newLock(" + variable + ")";
    }
}
