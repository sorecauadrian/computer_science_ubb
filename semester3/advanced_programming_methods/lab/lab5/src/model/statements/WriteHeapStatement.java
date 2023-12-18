package model.statements;

import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyDictionaryInterface;
import model.adts.MyHeapInterface;
import model.expressions.Expression;
import model.values.ReferenceValue;
import model.values.Value;

public class WriteHeapStatement implements Statement
{
    private final String variableName;
    private final Expression expression;

    public WriteHeapStatement(String variableName, Expression expression)
    {
        this.variableName = variableName;
        this.expression = expression;
    }

    @Override
    public String toString() {return "writeHeap(" + this.variableName + ", " + this.expression.toString() + ")";}

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException
    {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();
        MyHeapInterface<Value> heap = state.getHeapTable();

        // we check if variableName is a variable defined in symbolTable
        if (symbolTable.isVariableDefined(this.variableName))
        {
            Value value = symbolTable.lookup(this.variableName);
            // we check if its type is a ReferenceType
            if (value instanceof ReferenceValue)
            {
                int address = ((ReferenceValue) value).getAddress();
                // we check if the address associated in the symbolTable is a key in heap
                if (heap.exists(address))
                {
                    Value expressionValue = this.expression.evaluate(symbolTable, heap);
                    // the result of the expression must be of the same type as the type of variableName
                    if (expressionValue.getType().equals(heap.get(address).getType()))
                        // we access the heap using the address from variableName and that heap entry is updated to the result of the expression
                        // map doesn't allow duplicates, so this part is fine.
                        heap.put(address, expressionValue);
                    else
                        throw new InterpreterException("expression not of variable type");
                }
                else
                    throw new InterpreterException("value does not exist on heap");
            }
            else
                throw new InterpreterException("value is not a reference");
        }
        else
            throw new InterpreterException("variable not declared");

        state.setSymbolTable(symbolTable);
        state.setHeapTable(heap);
        return null;
    }

    @Override
    public Statement deepCopy() {return new WriteHeapStatement(this.variableName, this.expression.deepCopy());}
}
