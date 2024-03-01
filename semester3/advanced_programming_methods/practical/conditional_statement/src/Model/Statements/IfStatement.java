package Model.Statements;


import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.ADTs.MyStack_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.BoolType;
import Model.Types.Type;
import Model.Values.BoolValue;
import Model.Values.Value;


public class IfStatement implements Statement
{
    private Expression expression;
    private Statement if_statement,else_statement;

    public IfStatement(Expression expression,Statement if_statement,Statement else_statement)
    {
        this.expression=expression;
        this.if_statement=if_statement;
        this.else_statement=else_statement;
    }


    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        MyStack_Interface<Statement> stack= state.get_execution_stack();
        MyDictionary_Interface<String,Value> table=state.get_symbol_table();
        MyHeap_Interface<Value> heap= state.get_heap();
        Value result=expression.evaluate(table,heap);

        if(result.get_type().equals(new BoolType()))
        {
            BoolValue bool_result= (BoolValue) result;
            if(bool_result.get_value() == true)
            {
                stack.push(if_statement);
            }
            else
            {
                stack.push(else_statement);
            }
        }
        else
        {
            throw new MyException("Expression is not boolean!");
        }
        return null;

    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception
    {
        Type type_expression=expression.type_check(type_environment);

        if(type_expression.equals(new BoolType()))
        {
            MyDictionary_Interface<String,Type> if_environment;
            MyDictionary_Interface<String,Type> else_environment;

            if_environment=if_statement.type_check(type_environment);
            else_environment=else_statement.type_check(type_environment);
            return type_environment;
        }
        else
        {
            throw new Exception("The condition of IF has not the type bool");
        }
    }

    public String toString()
    {
        return " if " + this.expression.toString() + " then " + this.if_statement.toString() + " else " + this.else_statement.toString();
    }
}
