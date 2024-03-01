package model.statements;

import exceptions.DeclarationException;
import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.types.Type;
import model.values.Value;

public class VariableDeclarationStatement implements Statement
{
    private final String name;
    private final Type type;

    public VariableDeclarationStatement(String n, Type t)
    {
        this.name = n;
        this.type = t;
    }

    @Override
    public String toString() {return this.type.toString() + " " + this.name;}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyDictionaryInterface<String, Value> table = state.getDictionary();
        if (table.isVariableDefined(this.name))
            throw new DeclarationException("variable is already declared");
        else
        {
            Value defaultValue = this.type.defaultValue();
            table.add(name, defaultValue);
        }
        return state;
    }
}
