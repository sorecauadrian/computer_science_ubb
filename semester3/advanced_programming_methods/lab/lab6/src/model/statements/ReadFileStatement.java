package model.statements;

import exceptions.AssignmentException;
import exceptions.DeclarationException;
import exceptions.FileException;
import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.expressions.Expression;
import model.types.IntType;
import model.types.StringType;
import model.types.Type;
import model.values.IntValue;
import model.values.StringValue;
import model.values.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class ReadFileStatement implements Statement
{
    private final Expression expression;
    private final String variableName;

    public ReadFileStatement(Expression exp, String var_name)
    {
        this.expression = exp;
        this.variableName = var_name;
    }

    @Override
    public String toString() {return "readFile(" + this.expression.toString() + ", " + this.variableName + ")";}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyDictionaryInterface<String, Value> table = state.getSymbolTable();
        MyDictionaryInterface<StringValue, BufferedReader> fileTable = state.getFileTable();

        if (table.isVariableDefined(this.variableName))
        {
            Value value = table.lookup(this.variableName);
            if (value.getType().equals(new IntType()))
            {
                Value val = this.expression.evaluate(table, state.getHeapTable());
                if (val.getType().equals(new StringType()))
                {
                    StringValue stringValue = (StringValue) val;
                    BufferedReader reader = fileTable.lookup(stringValue);
                    try
                    {
                        String line = reader.readLine();
                        IntValue valueForVariable;
                        if (line == null)
                            valueForVariable = new IntValue();
                        else valueForVariable = new IntValue(Integer.parseInt(line));
                        table.update(variableName, valueForVariable);
                    }
                    catch (IOException exception) {throw new FileException("cannot read from file");}
                }
                else throw new AssignmentException("cannot read - expression not of type string");
            }
            else throw new AssignmentException("variable is not of type int");
        }
        else throw new DeclarationException("variable is not declared");

        state.setSymbolTable(table);
        state.setFileTable(fileTable);
        return null;
    }
    @Override
    public Statement deepCopy() {return new ReadFileStatement(this.expression.deepCopy(), this.variableName);}

    @Override
    public MyDictionaryInterface<String, Type> typecheck(MyDictionaryInterface<String, Type> typeEnv) throws InterpreterException
    {
        Type typexp = this.expression.typecheck(typeEnv);
        Type typevar = typeEnv.lookup(this.variableName);
        if (typexp.equals(new StringType()))
            if (typevar.equals(new IntType()))
                return typeEnv;
            else
                throw new InterpreterException("variable not of type int");
        else
            throw new InterpreterException("read file statement: expression not of type string");
    }
}
