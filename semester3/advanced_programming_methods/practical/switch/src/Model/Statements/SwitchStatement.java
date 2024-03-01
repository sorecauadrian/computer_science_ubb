package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.ADTs.MyStack_Interface;
import Model.Expressions.Expression;
import Model.Expressions.RelationalExpression;
import Model.ProgramState.ProgramState;
import Model.Types.BoolType;
import Model.Types.Type;
import Model.Values.BoolValue;
import Model.Values.Value;


public class SwitchStatement  implements Statement
{

    Expression expression;
    Expression expression1;
    Expression expression2;

    Statement statement1;
    Statement statement2;
    Statement statement3;


    public SwitchStatement(Expression expression, Expression expression1, Expression expression2, Statement statement1, Statement statement2, Statement statement3)
    {
        this.expression = expression;
        this.expression1 = expression1;
        this.expression2 = expression2;
        this.statement1 = statement1;
        this.statement2 = statement2;
        this.statement3 = statement3;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        MyStack_Interface<Statement> stack= state.get_execution_stack();
        MyDictionary_Interface<String, Value> table=state.get_symbol_table();
        MyHeap_Interface<Value> heap= state.get_heap();

        Statement statement_to_be_put_on_stack=new IfStatement(
                new RelationalExpression(expression,expression1,"=="),
                statement1,
                new IfStatement(
                        new RelationalExpression(expression,expression2,"=="),
                        statement2,
                        statement3));
        stack.push(statement_to_be_put_on_stack);


        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        Type expression_type=expression.type_check(type_environment);
        Type expression1_type=expression1.type_check(type_environment);
        Type expression2_type=expression2.type_check(type_environment);

        if(expression_type.equals(expression1_type) && expression_type.equals(expression2_type))
        {
            statement1.type_check(type_environment);
            statement2.type_check(type_environment);
            statement3.type_check(type_environment);

            return  type_environment;
        }
        else
        {
            throw new Exception("Types mismatch between expressions!");
        }

    }

    public String toString()
    {

        return "switch(" + expression.toString() + ")" + "(case " + expression1.toString() + " : " + statement1.toString()+") (case " + expression2.toString() + " : " + statement2.toString() + ") (default " + statement3.toString() + ")";

    }

}
