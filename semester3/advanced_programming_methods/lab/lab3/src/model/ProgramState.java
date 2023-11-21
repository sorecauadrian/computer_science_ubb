package model;

import model.adts.*;
import model.statements.Statement;
import model.values.StringValue;
import model.values.Value;

import java.io.BufferedReader;

public class ProgramState
{
    private MyStackInterface<Statement> executionStack;
    private MyDictionaryInterface<String, Value> symbolTable;
    private MyListInterface<Value> out;
    private MyDictionaryInterface<StringValue, BufferedReader> fileTable;

    public ProgramState(MyStackInterface<Statement> stk, MyDictionaryInterface<String, Value> symtbl, MyListInterface<Value> ot, MyDictionaryInterface<StringValue, BufferedReader> filetbl, Statement prg)
    {
        this.executionStack = stk;
        this.symbolTable = symtbl;
        this.out = ot;
        this.fileTable = filetbl;

        if (prg != null)
            this.executionStack.push(prg);
    }

    public MyStackInterface<Statement> getExecutionStack() {return this.executionStack;}
    public void setExecutionStack(MyStackInterface<Statement> s) {this.executionStack = s;}

    public MyDictionaryInterface<String, Value> getSymbolTable() {return this.symbolTable;}
    public void setSymbolTable(MyDictionaryInterface<String, Value> symtbl) {this.symbolTable = symtbl;}

    public MyListInterface<Value> getOutputList() {return this.out;}
    public void setOutputList(MyListInterface<Value> o) {this.out = o;}

    public MyDictionaryInterface<StringValue, BufferedReader> getFileTable() {return this.fileTable;}
    public void setFileTable(MyDictionaryInterface<StringValue, BufferedReader> filetbl) {this.fileTable = filetbl;}

    @Override
    public String toString()
    {
        return
                " --------Execution Stack-------- \n" +
                this.executionStack.toString() + '\n' +
                " -------- Symbol  Table -------- \n" +
                this.symbolTable.toString() + '\n' +
                " -------- Output Console -------- \n" +
                this.out.toString() + '\n' +
                " --------  File  Table  -------- \n" +
                this.fileTable.keysToString() + '\n';
    }

}
