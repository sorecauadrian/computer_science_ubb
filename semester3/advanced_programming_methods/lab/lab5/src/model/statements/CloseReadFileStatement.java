package model.statements;

import exceptions.FileException;
import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.expressions.Expression;
import model.types.StringType;
import model.values.StringValue;
import model.values.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class CloseReadFileStatement implements Statement
{
    private final Expression expression;

    public CloseReadFileStatement(Expression exp) {this.expression = exp;}

    @Override
    public String toString() {return "close(" + this.expression.toString() + ")";}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyDictionaryInterface<StringValue, BufferedReader> fileTable = state.getFileTable();

        Value value = this.expression.evaluate(state.getSymbolTable(), state.getHeapTable());
        if (value.getType().equals(new StringType()))
        {
            StringValue stringValue = (StringValue) value;
            if (fileTable.isVariableDefined(stringValue))
            {
                BufferedReader br = fileTable.lookup(stringValue);
                try {br.close();}
                catch (IOException exception) {throw new FileException("could not close file " + exception.getMessage());}
                fileTable.remove(stringValue);
            }
            else throw new FileException("file to close does not exist");
        }
        else throw new FileException("file name is not a string");

        state.setFileTable(fileTable);
        return null;
    }
    @Override
    public Statement deepCopy() {return new CloseReadFileStatement(this.expression.deepCopy());}
}
