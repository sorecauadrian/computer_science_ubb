package model.statements;

import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.adts.MyStackInterface;
import model.types.Type;

public class CompoundStatement implements Statement
{
    private final Statement statement1;
    private final Statement statement2;

    public CompoundStatement(Statement s1, Statement s2)
    {
        this.statement1 = s1;
        this.statement2 = s2;
    }

    @Override
    public String toString() {return "(" + this.statement1.toString() + ";" + this.statement2.toString() + ")";}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyStackInterface<Statement> stack = state.getExecutionStack();

        stack.push(this.statement2);
        stack.push(this.statement1);

        state.setExecutionStack(stack);
        return null;
    }
    @Override
    public Statement deepCopy() {return new CompoundStatement(this.statement1.deepCopy(), this.statement2.deepCopy());}

    @Override
    public MyDictionaryInterface<String, Type> typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException {return this.statement2.typecheck(this.statement1.typecheck(typeEnv));}
}
