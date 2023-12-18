package model.statements;

import exceptions.AssignmentException;
import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.expressions.Expression;
import model.values.Value;


public class AssignmentStatement implements Statement
{
    private final String id;
    private final Expression expression;

    public AssignmentStatement(String i, Expression e)
    {
        this.id = i;
        this.expression = e;
    }

    @Override
    public String toString() {return this.id + " = " + this.expression.toString();}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyDictionaryInterface<String, Value> table = state.getSymbolTable();

        if (table.isVariableDefined(id))
        {
            Value value = this.expression.evaluate(table, state.getHeapTable());
            if (value.getType().equals(table.lookup(id).getType()))
                table.update(id, value);
            else
                throw new AssignmentException("type of expression and type of variable do not match");
        }
        else
            throw new AssignmentException("variable is not declared");

        state.setSymbolTable(table);
        return null;
    }
    @Override
    public Statement deepCopy() {return new AssignmentStatement(this.id, this.expression.deepCopy());}

}
