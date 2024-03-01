package model.statements;

import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionary;
import model.adts.MyDictionaryInterface;
import model.adts.MyStack;
import model.adts.MyStackInterface;
import model.values.Value;

import java.util.Map;

public class ForkStatement implements Statement
{
    Statement statement;
    public ForkStatement(Statement statement) {this.statement = statement;}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyDictionaryInterface<String, Value> newSymbolTable = new MyDictionary<>();
        for (Map.Entry<String, Value> entry : state.getSymbolTable().getContent().entrySet())
            newSymbolTable.add(entry.getKey(), entry.getValue().deepCopy());

        MyStackInterface<Statement> stack = new MyStack<>();
        stack.push(statement);

        ProgramState newProgram = new ProgramState(stack, newSymbolTable, state.getOutputList(), state.getFileTable(), state.getHeapTable());
        newProgram.setId();

        return newProgram;
    }

    @Override
    public String toString() {return "fork(" + this.statement.toString() + ")";}

    @Override
    public Statement deepCopy() {return new ForkStatement(this.statement.deepCopy());}

}
