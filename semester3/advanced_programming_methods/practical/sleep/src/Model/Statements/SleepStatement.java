package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.Type;
import Model.Values.Value;

public class SleepStatement implements Statement
{

    Integer number;

    public SleepStatement(Integer number)
    {
        this.number = number;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        if(number.equals(0))
        {

        }
        else
        {
            state.get_execution_stack().push(new SleepStatement(number-1));
        }

        return null;
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception
    {
        return type_environment;
    }

    @Override
    public String toString()
    {
        return "sleep(" +
                 + number +
                ");";
    }
}
