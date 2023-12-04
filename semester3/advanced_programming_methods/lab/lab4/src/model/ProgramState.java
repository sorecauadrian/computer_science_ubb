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
    private MyHeapInterface<Value> heapTable;

    public ProgramState(MyStackInterface<Statement> stack, MyDictionaryInterface<String, Value> symbolTable, MyListInterface<Value> out, MyDictionaryInterface<StringValue, BufferedReader> fileTable, MyHeapInterface<Value> heapTable, Statement prg)
    {
        this.executionStack = stack;
        this.symbolTable = symbolTable;
        this.out = out;
        this.fileTable = fileTable;
        this.heapTable = heapTable;

        if (prg != null)
            this.executionStack.push(prg);
    }

    public MyStackInterface<Statement> getExecutionStack() {return this.executionStack;}
    public void setExecutionStack(MyStackInterface<Statement> stack) {this.executionStack = stack;}

    public MyDictionaryInterface<String, Value> getSymbolTable() {return this.symbolTable;}
    public void setSymbolTable(MyDictionaryInterface<String, Value> symbolTable) {this.symbolTable = symbolTable;}

    public MyListInterface<Value> getOutputList() {return this.out;}
    public void setOutputList(MyListInterface<Value> out) {this.out = out;}

    public MyDictionaryInterface<StringValue, BufferedReader> getFileTable() {return this.fileTable;}
    public void setFileTable(MyDictionaryInterface<StringValue, BufferedReader> fileTable) {this.fileTable = fileTable;}

    public MyHeapInterface<Value> getHeapTable() {return this.heapTable;}
    public void setHeapTable(MyHeapInterface<Value> heapTable) {this.heapTable = heapTable;}


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
                this.fileTable.keysToString() + '\n' +
                " --------  Heap  Table  -------- \n" +
                this.heapTable.toString() + '\n';
    }

}
