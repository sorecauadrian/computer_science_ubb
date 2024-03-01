package model.statements;

import exceptions.AssignmentException;
import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.adts.MyHeapInterface;
import model.expressions.Expression;
import model.types.ReferenceType;
import model.values.ReferenceValue;
import model.values.Value;

public class AllocateHeapStatement implements Statement
{
    private final String variableName;
    private final Expression expression;

    public AllocateHeapStatement(String variableName, Expression expression)
    {
        this.variableName = variableName;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();
        MyHeapInterface<Value> heapTable = state.getHeapTable();

        // check if variableName is a variable in symbolTable
        if (symbolTable.isVariableDefined(this.variableName))
        {
            // check if its type is ReferenceType
            if (symbolTable.lookup(this.variableName).getType() instanceof ReferenceType)
            {
                // evaluate the expression to a value
                Value value = this.expression.evaluate(symbolTable, heapTable);
                Value tableValue = symbolTable.lookup(this.variableName);
                // compare the type of the value to the type from the value associated to variableName in symbolTable
                if (value.getType().equals(((ReferenceType)(tableValue.getType())).getInner()))
                {
                    // create a new entry in the heapTable such that a new key is generated
                    int address = heapTable.allocate(value);
                    // in symbolTable update the ReferenceValue associated to the variableName
                    symbolTable.update(this.variableName, new ReferenceValue(address, value.getType()));
                }
                else
                    throw new AssignmentException("value is not of correct type");
            }
            else
                throw new AssignmentException("variable is not of reference type");
        }
        else
            throw new AssignmentException("variable is not declared");

        state.setSymbolTable(symbolTable);
        state.setHeapTable(heapTable);
        return null;
    }

    @Override
    public String toString() {return "new(" + this.variableName + ", " + this.expression + ")";}

    @Override
    public Statement deepCopy() {return new AllocateHeapStatement(this.variableName, this.expression.deepCopy());}
}
