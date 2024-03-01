package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.BoolType;
import Model.Types.Type;

public class Conditional_AssignmentStatement implements Statement
{

    private Expression expression1,expression2,expression3;
    private String variable_name;


    public Conditional_AssignmentStatement(Expression expression1, Expression expression2, Expression expression3, String variable_name)
    {
        this.expression1 = expression1;
        this.expression2 = expression2;
        this.expression3 = expression3;
        this.variable_name = variable_name;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        Statement if_statement = new IfStatement(expression1,
                new AssignmentStatement(variable_name, expression2),
                new AssignmentStatement(variable_name, expression3));
        state.get_execution_stack().push(if_statement);
        return null;
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        Type expression1_type=expression1.type_check(type_environment);
        Type expression2_type=expression2.type_check(type_environment);
        Type expression3_type=expression3.type_check(type_environment);

        if(!(expression1_type instanceof BoolType))
        {
            throw new Exception("Expression is not boolean in Conditional Assignment!");
        }

        Type variable_type=type_environment.lookup(variable_name);

        if(!(variable_type.equals(expression2_type)))
        {
            throw new Exception("Expression is not of the same type as the variable in Conditional Assignment!");
        }

        if(!(variable_type.equals(expression3_type)))
        {
            throw new Exception("Expression is not of the same type as the variable in Conditional Assignment!");
        }

        return type_environment;

    }


    public String toString()
    {
        return variable_name + "=" + expression1 + "?" + expression2 + ":" + expression3;
    }
}
