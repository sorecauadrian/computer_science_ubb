package model;

import model.adts.*;
import model.statements.Statement;
import model.values.Value;

public class ProgramState
{
    private MyStackInterface<Statement> executionStack;
    private MyDictionaryInterface<String, Value> symbolTable;
    private MyListInterface<Value> out;

    public ProgramState(MyStackInterface<Statement> stk, MyDictionaryInterface<String, Value> symtbl, MyListInterface<Value> ot, Statement prg)
    {
        this.executionStack = stk;
        this.symbolTable = symtbl;
        this.out = ot;

        this.executionStack.push(prg);
    }

    public MyStackInterface<Statement> getStack() {return this.executionStack;}
    public MyDictionaryInterface<String, Value> getDictionary() {return this.symbolTable;}
    public MyListInterface<Value> getList() {return this.out;}

    @Override
    public String toString()
    {
        return
                " --------Execution Stack-------- \n" +
                this.executionStack.toString() + '\n' +
                " -------- Symbol  Table -------- \n" +
                this.symbolTable.toString() + '\n' +
                " -------- Output Console -------- \n" +
                this.out.toString() + "\n";
    }

}
