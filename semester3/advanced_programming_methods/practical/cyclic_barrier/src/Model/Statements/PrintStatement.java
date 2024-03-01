package Model.Statements;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.ADTs.MyList_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.Type;
import Model.Values.Value;

public class PrintStatement implements Statement
{

    private Expression expression;

    public PrintStatement(Expression expression)
    {
        this.expression=expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {

        MyList_Interface<Value> output=state.get_output();
        MyDictionary_Interface<String,Value> table= state.get_symbol_table();
        MyHeap_Interface<Value> heap=state.get_heap();

        output.add(expression.evaluate(table,heap));

        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        Type type=expression.type_check(type_environment);
        return type_environment;
    }

    public String toString()
    {
        return "print("+expression.toString()+ ")";
    }

}
