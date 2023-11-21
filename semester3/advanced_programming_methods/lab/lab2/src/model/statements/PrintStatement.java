package model.statements;

import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyListInterface;
import model.expressions.Expression;
import model.values.Value;

public class PrintStatement implements Statement
{
    private final Expression expression;

    public PrintStatement(Expression e) {this.expression = e;}

    @Override
    public String toString() {return "print(" + this.expression.toString() + ")";}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyListInterface<Value> list = state.getList();
        list.addElement(this.expression.evaluate(state.getDictionary()));
        return state;
    }

}
