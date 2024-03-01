package model.statements;

import exceptions.FileException;
import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.adts.MyStackInterface;
import model.expressions.Expression;
import model.types.StringType;
import model.values.StringValue;
import model.values.Value;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class OpenReadFileStatement implements Statement
{
    private final Expression expression;
    public OpenReadFileStatement(Expression exp) {this.expression = exp;}

    @Override
    public String toString() {return "open(" + this.expression.toString() + ")";}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyStackInterface<Statement> stack = state.getExecutionStack();
        MyDictionaryInterface<String, Value> table = state.getSymbolTable();
        MyDictionaryInterface<StringValue, BufferedReader> fileTable = state.getFileTable();
        Value value = this.expression.evaluate(table);
        if (value.getType().equals(new StringType()))
        {
            StringValue stringValue = (StringValue) value;
            if (fileTable.isVariableDefined(stringValue))
                throw new FileException("file is already opened");
            else
            {
                try
                {
                    BufferedReader br = new BufferedReader(new FileReader(stringValue.getValue()));
                    fileTable.add(stringValue, br);
                }
                catch (IOException exception) {throw new FileException("file cannot be opened " + exception.getMessage());}
            }
            state.setExecutionStack(stack);
            state.setSymbolTable(table);
            state.setFileTable(fileTable);
            return null;
        }
        else
            throw new FileException("expression not of string type");
    }
    @Override
    public Statement deepCopy() {return new OpenReadFileStatement(this.expression.deepCopy());}
}
