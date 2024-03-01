package Model.Statements;


import Model.ADTs.MyDictionary_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.Type;

public class ReturnStatement implements Statement{
    @Override
    public ProgramState execute(ProgramState state) throws Exception {
        state.get_symbol_table_stack().pop();
        return null;
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        return type_environment;
    }

    @Override
    public String toString()
    {
        return "return";
    }
}
