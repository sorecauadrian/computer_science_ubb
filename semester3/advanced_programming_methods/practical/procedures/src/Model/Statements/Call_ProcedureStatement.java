package Model.Statements;

import Model.ADTs.MyDictionary;
import Model.ADTs.MyDictionary_Interface;
import Model.Expressions.Expression;
import Model.ProgramState.ProgramState;
import Model.Types.Type;
import Model.Values.Value;
import javafx.util.Pair;

import java.util.ArrayList;
import java.util.List;

public class Call_ProcedureStatement implements Statement
{


    private String fname;
    private List<Expression> expressions_list;

    public Call_ProcedureStatement(String fname, List<Expression> expressions_list)
    {
        this.fname = fname;
        this.expressions_list = expressions_list;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {

        Pair<List<String>, Statement> pair = state.get_procedure_table().lookup(fname);
        ArrayList<String> variables=(ArrayList<String>)  pair.getKey();

        Statement procedure_body=pair.getValue();
        MyDictionary_Interface<String, Value> new_symbol_table=new MyDictionary<>();

        for(int i=0;i<variables.size();i++)
        {
            new_symbol_table.add(variables.get(i),expressions_list.get(i).evaluate(state.get_symbol_table(), state.get_heap()));

        }

        state.get_symbol_table_stack().push(new_symbol_table);
        state.get_execution_stack().push(new ReturnStatement());
        state.get_execution_stack().push(procedure_body);

        return null;



    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        return type_environment;
    }

    public String toString() {
        return "call " + fname + "(" + expressions_list.toString() + ")";
    }
}
