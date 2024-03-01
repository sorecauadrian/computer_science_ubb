package model.statements;

import exceptions.ConditionException;
import exceptions.InterpreterException;
import exceptions.TypeException;
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

public class WhileStatement implements Statement
{
    private final Expression expression;
    private final Statement statement;

    public WhileStatement(Expression expression, Statement statement)
    {
        this.expression = expression;
        this.statement = statement;
    }

    @Override
    public String toString() {return "while(" + this.expression.toString() + ") " + this.statement.toString();}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyStackInterface<Statement> stack = state.getExecutionStack();

        Value condition = this.expression.evaluate(state.getSymbolTable(), state.getHeapTable());
        if (condition.getType().equals(new BoolType()))
        {
            if (condition.equals(new BoolValue(true)))
            {
                stack.push(new WhileStatement(this.expression, this.statement));
                stack.push(this.statement);
            }
        }
        else throw new ConditionException("condition expression is not a boolean");

        state.setExecutionStack(stack);
        return null;
    }

    @Override
    public Statement deepCopy() {return new WhileStatement(this.expression.deepCopy(), this.statement.deepCopy());}

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
        Type expressionType = this.expression.typecheck(typeEnv);
        if (expressionType.equals(new BoolType()))
        {
            this.statement.typecheck(clone(typeEnv));
            return typeEnv;
        }
        throw new InterpreterException("while: condition not of type bool");
    }
}
