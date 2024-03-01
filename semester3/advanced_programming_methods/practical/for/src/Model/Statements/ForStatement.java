package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.ADTs.MyStack_Interface;
import Model.Expressions.*;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import Model.Values.Value;

public class ForStatement implements Statement
{

    private Expression expression1, expression2,expression3;
    private Statement statement_in_for;
    private String v;


    public ForStatement(String v,Expression expression1, Expression expression2, Expression expression3, Statement statement_in_for)
    {
        this.v=v;
        this.expression1 = expression1;
        this.expression2 = expression2;
        this.expression3 = expression3;
        this.statement_in_for = statement_in_for;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {

        MyStack_Interface<Statement> execution_stack=state.get_execution_stack();

        Statement statement_in_while=new CompoundStatement(new AssignmentStatement("v",expression1),
                new WhileStatement(new RelationalExpression(new VariableExpression("v"),expression2,"<"),new CompoundStatement(statement_in_for,new AssignmentStatement("v",expression3))));

       state.get_execution_stack().push(statement_in_while);

        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception
    {
        Type expression1_type=expression1.type_check(type_environment);
        Type expression2_type=expression2.type_check(type_environment);
        Type expression3_type=expression3.type_check(type_environment);
        var type_of_v= new VariableExpression("v").type_check(type_environment);

        if(expression1_type.equals(new IntType()) && expression2_type.equals(new IntType()) && expression3_type.equals(new IntType()) && type_of_v.equals(new IntType()))
        {
            return type_environment;
        }
        else
            throw new Exception("Not of type Int");

    }

    public String toString(){
        return "for(" +expression1.toString()+";"+expression2.toString()+";"+ expression3.toString()+"){"+statement_in_for.toString()+ "}";
    }


}
