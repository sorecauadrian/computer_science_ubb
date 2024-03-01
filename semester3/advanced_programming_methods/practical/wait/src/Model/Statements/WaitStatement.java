package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.ValueExpression;
import Model.Expressions.VariableExpression;
import Model.ProgramState.ProgramState;
import Model.Types.Type;
import Model.Values.IntValue;

public class WaitStatement implements Statement
{

    Integer number;

    public WaitStatement(Integer number)
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
            Statement wait_statement=new CompoundStatement(new PrintStatement(new ValueExpression(new IntValue(number))),new WaitStatement(number-1));
            state.get_execution_stack().push(wait_statement);
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
        return "wait(" +
                + number +
                ");";
    }
}
