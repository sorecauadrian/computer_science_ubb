package Model.Statements;


import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyStack_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.Type;




public class CompoundStatement implements Statement
{
    private Statement first,second;

    public CompoundStatement(Statement first,Statement second)
    {
        this.first=first;
        this.second=second;
    }

    public Statement get_first()
    {
        return this.first;
    }

    public Statement get_second()
    {
        return this.second;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
       MyStack_Interface<Statement> stack=state.get_execution_stack();
       stack.push(second);
       stack.push(first);
       return null;
    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception
    {
        return second.type_check(first.type_check(type_environment));
    }


    public String toString()
    {
        return "(" + this.first.toString() + " ; " + this.second.toString() + ") ";
    }

}
