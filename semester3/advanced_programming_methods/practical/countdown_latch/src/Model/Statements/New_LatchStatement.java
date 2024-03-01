package Model.Statements;

import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import Model.Values.Value;

public class New_LatchStatement implements Statement
{

    private String variable;
    Expression expression;

    public New_LatchStatement(String variable, Expression expression)
    {
        this.variable = variable;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        Value expression_result = expression.evaluate(state.get_symbol_table(),state.get_heap());
        int number = ((IntValue)expression_result).get_value();
        int address=state.get_latch_table().get_free_address();
        state.get_latch_table().put(address,number);
        state.get_symbol_table().update(variable,new IntValue(address));

        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        var variable_type=type_environment.lookup(variable);
        var expression_type=expression.type_check(type_environment);

        if(variable_type.equals(new IntType()) && expression_type.equals(new IntType()))
        {
            return type_environment;
        }
        else
        {
            throw new Exception("Variable not of type INT in the New Latch Statement!");
        }
    }

    public String toString()
    {
        return "newLatch(" + variable + "," + expression.toString() + ")";
    }


}
