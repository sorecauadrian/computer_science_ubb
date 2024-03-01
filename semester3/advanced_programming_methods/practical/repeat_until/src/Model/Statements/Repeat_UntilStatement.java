package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.Expressions.NotExpression;
import Model.Expressions.RelationalExpression;
import Model.Expressions.ValueExpression;
import Model.ProgramState.ProgramState;
import Model.Types.BoolType;
import Model.Types.Type;
import Model.Values.BoolValue;

public class Repeat_UntilStatement implements Statement
{
    Statement statement;
    Expression expression;

    public Repeat_UntilStatement(Statement statement, Expression expression)
    {
        this.statement = statement;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        Statement repeat_until_statement=new WhileStatement(new NotExpression(expression),statement);
        state.get_execution_stack().push(repeat_until_statement);
        state.get_execution_stack().push(statement);

        return null;
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        Type type=expression.type_check(type_environment);
        this.statement.type_check(type_environment);

        if(type.equals(new BoolType()))
        {
            return type_environment;
        }
        else
        {
            throw new Exception("Expression is not bool in the repeat until statement!");
        }
    }

    @Override
    public String toString() {
        return "repeat(" +
                statement.toString() +
                " until " + expression +
                ')';
    }
}
