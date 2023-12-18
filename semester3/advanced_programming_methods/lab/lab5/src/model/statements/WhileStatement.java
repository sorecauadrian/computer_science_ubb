package model.statements;

import exceptions.ConditionException;
import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyStackInterface;
import model.expressions.Expression;
import model.types.BoolType;
import model.values.BoolValue;
import model.values.Value;

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
    public Statement deepCopy() {
        return new WhileStatement(this.expression.deepCopy(), this.statement.deepCopy());
    }
}
