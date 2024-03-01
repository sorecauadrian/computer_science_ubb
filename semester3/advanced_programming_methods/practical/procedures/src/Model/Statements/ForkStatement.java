package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyStack;
import Model.ADTs.MyStack_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.Type;
import Model.Values.Value;

public class ForkStatement implements Statement
{

    private Statement statement;

    public ForkStatement(Statement statement)
    {
        this.statement = statement;
    }

    public Statement get_statement()
    {
        return  statement;
    }

    public void set_statement(Statement statement)
    {
        this.statement=statement;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {

        MyStack_Interface<MyDictionary_Interface<String, Value>> symbol_table_stack_copy = new MyStack<>();
        MyStack_Interface<MyDictionary_Interface<String,Value>> symbol_table_stack_old = state.get_symbol_table_stack();
        for(MyDictionary_Interface<String, Value> entry : symbol_table_stack_old.get_values())
            symbol_table_stack_copy.push(entry.clone());
        return new ProgramState(new MyStack<>(),symbol_table_stack_copy,state.get_output(),state.get_file_table(),state.get_heap(),statement,state.get_procedure_table());
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        statement.type_check(type_environment);
        return type_environment;
    }

    public String toString()
    {
        return "fork(" + this.statement.toString()+ ")";
    }
}
