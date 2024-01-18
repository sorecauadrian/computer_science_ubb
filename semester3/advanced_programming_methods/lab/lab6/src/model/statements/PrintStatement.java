package model.statements;

import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.adts.MyListInterface;
import model.expressions.Expression;
import model.types.Type;
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
        MyListInterface<Value> list = state.getOutputList();

        list.addElement(this.expression.evaluate(state.getSymbolTable(), state.getHeapTable()));

        state.setOutputList(list);
        return null;
    }
    @Override
    public Statement deepCopy() {return new PrintStatement(this.expression.deepCopy());}

    @Override
    public MyDictionaryInterface<String, Type> typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException
    {
        this.expression.typecheck(typeEnv);
        return typeEnv;
    }
}
