package model.statements;

import exceptions.ConditionException;
import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionary;
import model.adts.MyDictionaryInterface;
import model.adts.MyStackInterface;
import model.expressions.Expression;
import model.types.BoolType;
import model.types.Type;
import model.values.BoolValue;
import model.values.Value;

import java.util.Map;

public class IfStatement implements Statement
{
    private final Expression expression;
    private final Statement thenStatement;
    private final Statement elseStatement;

    public IfStatement(Expression e, Statement tS, Statement eS)
    {
        this.expression = e;
        this.thenStatement = tS;
        this.elseStatement = eS;
    }

    @Override
    public String toString() {return "if (" + this.expression.toString() + ") then {" + this.thenStatement.toString() + "} else {" + this.elseStatement.toString() + "}";}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyStackInterface<Statement> stack = state.getExecutionStack();

        Value condition = this.expression.evaluate(state.getSymbolTable(), state.getHeapTable());
        if (!(condition.getType().equals(new BoolType())))
            throw new ConditionException("conditional expression is not a boolean");
        else if (condition.equals(new BoolValue(true)))
            stack.push(this.thenStatement);
        else
            stack.push(this.elseStatement);

        state.setExecutionStack(stack);
        return null;
    }
    @Override
    public Statement deepCopy() {return new IfStatement(this.expression.deepCopy(), this.thenStatement.deepCopy(), this.elseStatement.deepCopy());}

    private static MyDictionaryInterface<String, Type> clone(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException
    {
        MyDictionaryInterface<String, Type> newTypeEnv = new MyDictionary<>();
        for (Map.Entry<String, Type> entry : typeEnv.getContent().entrySet())
            newTypeEnv.add(entry.getKey(), entry.getValue());
        return newTypeEnv;
    }

    @Override
    public MyDictionaryInterface<String, Type> typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException
    {
        Type typexp = this.expression.typecheck(typeEnv);
        if (typexp.equals(new BoolType()))
        {
            this.thenStatement.typecheck(clone(typeEnv));
            this.elseStatement.typecheck(clone(typeEnv));
            return typeEnv;
        }
        throw new InterpreterException("the condition of if has not the type bool");
    }
}
