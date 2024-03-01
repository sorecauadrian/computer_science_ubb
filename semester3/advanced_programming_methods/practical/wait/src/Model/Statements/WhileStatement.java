package Model.Statements;


import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyHeap_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.BoolType;
import Model.Types.Type;
import Model.Values.BoolValue;
import Model.Values.Value;

public class WhileStatement implements Statement
{

    private Expression expression;
    private Statement statement;

    public WhileStatement(Expression expression,Statement statement)
    {
        this.expression = expression;
        this.statement = statement;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception //daca expresia este falsa nu face nimic, se trece la urmatorul statement din stiva, altfel pune statementul while-ului la capul stivei
    {
        MyDictionary_Interface<String, Value> symbol_table=state.get_symbol_table();
        MyHeap_Interface<Value> heap=state.get_heap();
        Value expression_evaluation_result=expression.evaluate(symbol_table,heap);

        if(expression_evaluation_result.get_type().equals(new BoolType()))
        {
            BoolValue expression_evaluation_result_as_bool= (BoolValue) expression_evaluation_result;
            if(expression_evaluation_result_as_bool.get_value()==true)
            {
                state.get_execution_stack().push(new WhileStatement(expression,statement));
                state.get_execution_stack().push(statement);
            }
        }
        else
        {
            throw new MyException("Expression is not bool!");
        }

        return null;

    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        Type type=expression.type_check(type_environment);

        if(type.equals(new BoolType()))
        {
            return type_environment;
        }
        else
        {
            throw new Exception("Expression is not bool in the while statement!");
        }
    }

    public String toString()
    {
        return "while(" + expression.toString()+ ")"+statement.toString()+ "";
    }
}
