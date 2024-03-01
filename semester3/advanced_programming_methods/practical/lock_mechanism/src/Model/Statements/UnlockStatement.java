package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class UnlockStatement implements Statement
{

    String variable;


    public UnlockStatement(String variable)
    {
        this.variable = variable;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        Lock lock=new ReentrantLock();
        lock.lock();

        var symbolTable=state.get_symbol_table();
        var lockTable=state.get_lock_table();

        if(!symbolTable.is_defined(this.variable))
        {
            throw new Exception("Variable not declared in the Unlock Statement!");
        }
        if(!symbolTable.lookup(this.variable).get_type().equals(new IntType()))
        {
            throw new Exception("Variable not of Integer Type in the Unlock Statement!");
        }

        int foundIndex=((IntValue)symbolTable.lookup(this.variable)).get_value();

        if(lockTable.lookup(foundIndex).equals(state.get_id()))
        {
            lockTable.replace(foundIndex,-1);
        }

        lock.unlock();

        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> typeEnvironment) throws Exception {
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
    public String toString() {
        return "unlock(" + variable + ")";
    }
}
