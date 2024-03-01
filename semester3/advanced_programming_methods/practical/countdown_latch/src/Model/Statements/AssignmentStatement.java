package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.Type;
import Model.Values.Value;

public class AssignmentStatement implements Statement
{
    private String id;
    private Expression expression;

    public AssignmentStatement(String id,Expression expression)
    {
        this.id=id;
        this.expression=expression;
    }
    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        MyDictionary_Interface<String,Value> table=state.get_symbol_table();
        MyHeap_Interface<Value> heap=state.get_heap();

        if(table.is_defined(this.id))
        {
            Value result=this.expression.evaluate(table,heap);
            if(result.get_type().equals(table.lookup(this.id).get_type()))
            {
                table.update(this.id,result);
            }
            else
            {
                throw new MyException("Type of expression and type of variable do not match.");
            }
        }
        else
        {
            throw new MyException("Variable id is not declared.");
        }
        return null;
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception
    {
        Type type_variable=type_environment.lookup(id);
        Type type_expression=expression.type_check(type_environment);

        if(type_variable.equals(type_expression))
        {
            return type_environment;
        }
        else
        {
            throw new Exception("Assignment: right hand side and left hand side have different types");
        }
    }

    public String toString()
    {
        return this.id + "=" + this.expression.toString();
    }
}
