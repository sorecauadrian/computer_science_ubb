package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyStack;
import Model.ProgramState.ProgramState;
import Model.Types.Type;

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
        return new ProgramState(new MyStack<>(),state.get_symbol_table().clone(),state.get_output(),state.get_file_table(),state.get_heap(),statement);
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
