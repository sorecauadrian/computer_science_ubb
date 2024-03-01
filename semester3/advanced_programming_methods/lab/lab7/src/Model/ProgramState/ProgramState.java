package Model.ProgramState;

import Exceptions.MyException;
import Model.ADTs.*;
import Model.Statements.Statement;
import Model.Values.Value;

import java.io.BufferedReader;

public class ProgramState
{
    private MyStack_Interface<Statement> execution_stack;
    private MyDictionary_Interface<String,Value> symbol_table;
    private MyList_Interface<Value> output;
    private MyDictionary_Interface<String,BufferedReader> file_table;
    private MyHeap_Interface<Value> heap;

    private int id;
    private static int global_id_seed =1;





    public ProgramState(Statement program)
    {
        this.execution_stack= new MyStack<Statement>();
        this.symbol_table=new MyDictionary<String,Value>();
        this.output=new MyList<Value>();
        this.file_table=new MyDictionary<String, BufferedReader>();
        this.heap=new MyHeap<Value>();
        this.id=1;

        this.execution_stack.push(program);
    }

    public ProgramState(MyStack_Interface<Statement> execution_stack, MyDictionary_Interface<String, Value> symbol_table, MyList_Interface<Value> output, MyDictionary_Interface<String, BufferedReader> file_table,MyHeap_Interface<Value> heap,Statement original_program)
    {
        this.execution_stack=execution_stack;
        this.symbol_table=symbol_table;
        this.output=output;
        this.file_table=file_table;
        this.heap=heap;
        this.execution_stack.push(original_program);
        this.id= get_global_id_seed();
    }

    public ProgramState execute_one_step() throws Exception
    {
        if(execution_stack.is_empty())
        {
            throw new MyException("Execution Stack is empty!");
        }

        Statement top=execution_stack.pop();
        return top.execute(this);
    }

    public boolean is_not_completed()
    {
        return !execution_stack.is_empty();
    }


    public MyStack_Interface<Statement> get_execution_stack()
    {
        return this.execution_stack;
    }

    public void set_execution_stack(MyStack_Interface<Statement> execution_stack)
    {
        this.execution_stack=execution_stack;
    }

    public MyDictionary_Interface<String,Value> get_symbol_table()
    {
        return this.symbol_table;
    }

    public void set_symbol_table(MyDictionary_Interface<String,Value> symbol_table)
    {
        this.symbol_table=symbol_table;
    }

    public MyList_Interface<Value> get_output()
    {
        return this.output;
    }

    public void set_output(MyList_Interface<Value> output)
    {
        this.output=output;
    }

    public String toString()
    {

        return "Program State with id: " + id + "\n" +
                "ExecutionStack:\n " + execution_stack.toString() +"\n" +
                "SymbolTable:\n " + symbol_table.toString() + "\n" +
                "Output:\n " + output.toString()  + "\n" +
                "File table\n" + file_table.toString() + "\n"+
                "Heap\n" + heap.toString()+"\n\n\n";

    }


    public MyDictionary_Interface<String, BufferedReader> get_file_table()
    {
        return file_table;
    }

    public void set_file_table(MyDictionary_Interface<String, BufferedReader> file_table)
    {
        this.file_table = file_table;
    }

    public MyHeap_Interface<Value> get_heap()
    {
        return this.heap;
    }

    public void set_heap(MyHeap_Interface<Value> heap)
    {
        this.heap=heap;
    }

    public int  get_id()
    {
        return id;
    }

    public  void set_id(int id)
    {
        this.id = id;
    }

    public synchronized int get_global_id_seed()
    {
        global_id_seed *=10;
        return global_id_seed;
    }
}
