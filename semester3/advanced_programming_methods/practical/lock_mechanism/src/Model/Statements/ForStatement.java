package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyStack_Interface;
import Model.Expressions.*;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;

public class ForStatement implements Statement
{

    private Expression expression1, expression2,expression3;
    private Statement statementInFor;
    private String v;


    public ForStatement(String v,Expression expression1, Expression expression2, Expression expression3, Statement statementInFor)
    {
        this.v=v;
        this.expression1 = expression1;
        this.expression2 = expression2;
        this.expression3 = expression3;
        this.statementInFor = statementInFor;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {

        Statement statementInWhile= new CompoundStatement(new AssignmentStatement(this.v,expression1),
                new WhileStatement(new RelationalExpression(new VariableExpression(this.v),expression2,"<"),new CompoundStatement(statementInFor,new AssignmentStatement(this.v,expression3))));

        state.get_execution_stack().push(statementInWhile);

        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> typeEnvironment) throws Exception
    {
        Type expression1Type=expression1.type_check(typeEnvironment);
        Type expression2Type=expression2.type_check(typeEnvironment);
        Type expression3Type=expression3.type_check(typeEnvironment);
        var typeOfV= new VariableExpression(this.v).type_check(typeEnvironment);

        if(expression1Type.equals(new IntType()) && expression2Type.equals(new IntType()) && expression3Type.equals(new IntType()) && typeOfV.equals(new IntType()))
        {
            return typeEnvironment;
        }
        else
            throw new Exception("Not of type Int");

    }

    public String toString(){
        return "for(" +expression1.toString()+";"+expression2.toString()+";"+ expression3.toString()+"){"+ statementInFor.toString()+ "}";
    }


}
