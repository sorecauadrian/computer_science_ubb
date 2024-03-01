package Tests;

import Controller.Controller;
import Exceptions.*;
import Model.ADTs.*;
import Model.Expressions.ArithmeticExpression;
import Model.Expressions.ValueExpression;
import Model.Expressions.Expression;
import Model.Expressions.VariableExpression;
import Model.ProgramState.ProgramState;
import Model.Statements.*;
import Model.Types.IntType;
import Model.Values.Value;
import Model.Values.IntValue;
import Model.Values.StringValue;
import Model.Types.StringType;
import Repository.Repository;
import Repository.Repository_Interface;

import java.io.BufferedReader;

public class Test_Statement_File_Statements
{
    public Test_Statement_File_Statements(){};


    public void test() throws Exception
    {
        Statement expression = new CompoundStatement(
                new Variable_DeclarationStatement("varf",new StringType()),
                    new CompoundStatement(
                        new AssignmentStatement("varf",new ValueExpression(new StringValue("test.in"))),
                            new CompoundStatement(
                                new Open_FileStatement(new VariableExpression("varf")),
                                    new CompoundStatement(
                                        new Variable_DeclarationStatement("varc",new IntType()),
                                            new CompoundStatement(
                                                new Read_FileStatement(new VariableExpression("varf"),"varc"),
                                                    new CompoundStatement(
                                                        new PrintStatement(new VariableExpression("varc")),
                                                            new CompoundStatement(
                                                                new Read_FileStatement(new VariableExpression("varf"),"varc") ,
                                                                    new CompoundStatement(
                                                                            new PrintStatement(new VariableExpression("varc")),new Close_FileStatement(new VariableExpression("varf"))))))))));
        ProgramState program_state=new ProgramState(expression);
        Repository_Interface repository=new Repository("log_test.txt");
        Controller controller=new Controller(repository);
        controller.add_program_state(program_state);
        controller.execute_all_steps();
        System.out.println("Test passed!");



    }


}
