package Tests;
import Exceptions.*;
import Model.ADTs.*;
import Model.Expressions.ValueExpression;
import Model.ProgramState.ProgramState;
import Model.Statements.AssignmentStatement;
import Model.Statements.Statement;
import Model.Statements.Variable_DeclarationStatement;
import Model.Types.IntType;
import Model.Values.Value;
import Model.Values.IntValue;

import java.io.BufferedReader;

//obsolete!!!
/*public class Test_Statements_Assignment
{
    public Test_Statements_Assignment(){};

    public void test()
    {
        MyStack<Statement> execution_stack=new MyStack<Statement>();
        MyDictionary<String,Value> symbol_table=new MyDictionary<String, Value>();
        MyList<Value> output=new MyList<Value>();
        MyDictionary<String, BufferedReader> file_table=new MyDictionary<>();
        Statement program=new Variable_DeclarationStatement("variable",new IntType());

        ProgramState program_state=new ProgramState(execution_stack,symbol_table,output,file_table,program);

        Statement variable_declaration=new Variable_DeclarationStatement("variable",new IntType());

        try
        {
            program_state=variable_declaration.execute(program_state);
            assert program_state.get_symbol_table().is_defined("variable");
            System.out.println("Test Passed!\n");

        } catch (Exception exception)
        {
            assert false;
        }

        Statement variable_assignment=new AssignmentStatement("variable",new ValueExpression(new IntValue(2)));

        try
        {
            assert program_state.get_symbol_table().is_defined("variable");
            program_state=variable_assignment.execute(program_state);
            assert program_state.get_symbol_table().is_defined("variable");
            Value result=program_state.get_symbol_table().lookup("variable");
            assert result.equals(new IntValue(2));
            System.out.println("Test Passed!\n");

        } catch (Exception exception)
        {
            System.out.println("Test Failed!\n");
        }


    }


}
*/