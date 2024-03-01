package View;

import Model.ADTs.*;
import Model.Expressions.*;
import Model.ProgramState.*;
import Model.Statements.*;
import Model.Types.*;
import Model.Values.*;
import Repository.*;
import Controller.*;
import Tests.*;

public class Interpreter
{
    public static void main(String[] args) throws Exception
    {


        Statement expression0=new PrintStatement(
                new ArithmeticExpression(
                        new ValueExpression(new IntValue(10)),
                        new ValueExpression((new IntValue(0))),
                        "/")
        );

        Statement expression1=new CompoundStatement(
                new Variable_DeclarationStatement(
                        "v",
                        new IntType()),
                new CompoundStatement(
                        new AssignmentStatement(
                                "v",
                                new ValueExpression(new IntValue(2))),
                        new PrintStatement(new VariableExpression("v"))
                )
        );

        Statement expression2=new CompoundStatement(
                new Variable_DeclarationStatement(
                        "a",
                        new IntType()),
                new CompoundStatement(
                        new Variable_DeclarationStatement(
                                "b",
                                new IntType()),
                        new CompoundStatement(
                                new AssignmentStatement(
                                        "a",
                                        new ArithmeticExpression(
                                                new ValueExpression(new IntValue(2)),
                                                new ArithmeticExpression(
                                                        new ValueExpression(new IntValue(3)),
                                                        new ValueExpression(new IntValue(5)),
                                                        "*"),
                                                "+")),
                                new CompoundStatement(
                                        new AssignmentStatement(
                                                "b",
                                                new ArithmeticExpression(
                                                        new VariableExpression("a"),
                                                        new ValueExpression(new IntValue(1)),
                                                        "+")
                                        ),
                                        new PrintStatement(
                                                new VariableExpression("b"))
                                )
                        )
                )
        );

        Statement expression3=new CompoundStatement(
                new Variable_DeclarationStatement(
                        "a",
                        new BoolType()),
                new CompoundStatement(
                        new Variable_DeclarationStatement(
                                "v",
                                new IntType()),
                        new CompoundStatement(
                                new AssignmentStatement(
                                        "a",
                                        new ValueExpression(new BoolValue(true))),
                                new CompoundStatement(
                                        new IfStatement(
                                                new VariableExpression("a"),
                                                new AssignmentStatement(
                                                        "v",
                                                        new ValueExpression(new IntValue(2))),
                                                new AssignmentStatement(
                                                        "v",
                                                        new ValueExpression(new IntValue(3)))),
                                        new PrintStatement(
                                                new VariableExpression("v")
                                        )


                                )
                        )
                )
        );

        Statement expression4= new CompoundStatement(
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

        Statement expression5=new CompoundStatement(
                new Variable_DeclarationStatement("variable",new IntType()),
                new CompoundStatement(
                        new AssignmentStatement("variable",new ValueExpression(new IntValue(4))),
                        new WhileStatement(
                            new RelationalExpression(new VariableExpression("variable"),new ValueExpression(new IntValue(0)),">"),
                            new CompoundStatement(
                                new PrintStatement(new VariableExpression("variable")),
                                new AssignmentStatement("variable",new ArithmeticExpression("-",new VariableExpression("variable"),new ValueExpression(new IntValue(1))))
                            )
                   )
            )
        );

        Statement expression6=new CompoundStatement(
                new Variable_DeclarationStatement("v",new ReferenceType(new IntType())),
                new CompoundStatement(
                        new NewStatement("v",new ValueExpression(new IntValue(20))),
                        new CompoundStatement(
                                new PrintStatement(new Heap_ReadExpression(new VariableExpression("v"))),
                                new CompoundStatement(
                                        new Variable_DeclarationStatement("a",new ReferenceType(new ReferenceType(new IntType()))),
                                        new CompoundStatement(
                                                new NewStatement("a",new VariableExpression("v")),
                                                new CompoundStatement(
                                                        new NewStatement("v",new ValueExpression(new IntValue(30))),
                                                        new PrintStatement(new ArithmeticExpression("+",new Heap_ReadExpression(new Heap_ReadExpression(new VariableExpression("a"))),new ValueExpression(new IntValue(5))))
                                                )
                                        )
                                )
                        )
                )
        );

        Statement expression7=new CompoundStatement(
                new Variable_DeclarationStatement("v",new ReferenceType(new IntType())),
                new CompoundStatement(
                        new NewStatement("v",new ValueExpression(new IntValue(20))),
                        new CompoundStatement(
                                new PrintStatement(new Heap_ReadExpression(new VariableExpression("v"))),
                                new CompoundStatement(
                                        new Variable_DeclarationStatement("a",new ReferenceType(new ReferenceType(new IntType()))),
                                        new CompoundStatement(
                                                new NewStatement("a",new VariableExpression("v")),
                                                new CompoundStatement(
                                                        new Heap_WriteStatement("v",new ValueExpression(new IntValue(30))),
                                                        new PrintStatement(new ArithmeticExpression("+",new Heap_ReadExpression(new Heap_ReadExpression(new VariableExpression("a"))),new ValueExpression(new IntValue(5))))
                                                )
                                        )
                                )
                        )
                )
        );

        Statement expression8=new CompoundStatement(
                new Variable_DeclarationStatement("v",new ReferenceType(new IntType())),
                new CompoundStatement(
                        new NewStatement("v",new ValueExpression(new IntValue(20))),
                        new CompoundStatement(
                                new Variable_DeclarationStatement("a",new ReferenceType(new ReferenceType(new IntType()))),
                                new CompoundStatement(
                                        new NewStatement("a",new VariableExpression("v")),
                                        new CompoundStatement(
                                                new NewStatement("v",new ValueExpression(new IntValue(30))),
                                                new PrintStatement(new Heap_ReadExpression(new Heap_ReadExpression(new VariableExpression("a"))))

                                                )
                                        )
                                )
                        )
                );

        Statement statement_for_fork = new CompoundStatement(new Heap_WriteStatement("a",new ValueExpression(new IntValue(30))),
                new CompoundStatement(new AssignmentStatement("v",new ValueExpression(new IntValue(32))),
                        new CompoundStatement(new PrintStatement(new VariableExpression("v")),new PrintStatement(new Heap_ReadExpression(new VariableExpression("a"))))));
        Statement expression9 = new CompoundStatement(new Variable_DeclarationStatement("v", new IntType()),
                new CompoundStatement(new Variable_DeclarationStatement("a",new ReferenceType(new IntType())),
                        new CompoundStatement(new AssignmentStatement("v",new ValueExpression(new IntValue(10))),
                                new CompoundStatement(new NewStatement("a",new ValueExpression(new IntValue(22))),
                                        new CompoundStatement(new ForkStatement(statement_for_fork),new CompoundStatement(new PrintStatement(new VariableExpression("v")),new PrintStatement(new Heap_ReadExpression(new VariableExpression("a")))))))));

//        Statement expression10=new CompoundStatement(new Variable_DeclarationStatement("v",new IntType()),
//                new CompoundStatement(new AssignmentStatement("v",new ValueExpression(new BoolValue(true))),
//                        new PrintStatement(new VariableExpression("v"))
//                        )
//        );
        //menu creation
        TextMenu menu=new TextMenu();
        menu.add_command(new ExitCommand("Exit","Exit"));


        //first example (from A3)

        ProgramState program_state_1=new ProgramState(expression1);
        Repository_Interface repository1=new Repository("log1.txt");
        Controller controller1=new Controller(repository1);
        controller1.add_program_state(program_state_1);

        try
        {
            expression1.type_check(new MyDictionary<String,Type>());
            menu.add_command(new RunExample("1",expression1.toString(),controller1));
        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }


        //second example (from A3)

        ProgramState program_state_2=new ProgramState(expression2);
        Repository_Interface repository2=new Repository("log2.txt");
        Controller controller2=new Controller(repository2);
        controller2.add_program_state(program_state_2);

        try
        {
            expression2.type_check(new MyDictionary<String,Type>());
            menu.add_command(new RunExample("2",expression2.toString(),controller2));

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }

        //third example (from A3)

        ProgramState program_state_3=new ProgramState(expression3);
        Repository_Interface repository3=new Repository("log3.txt");
        Controller controller3=new Controller(repository3);
        controller3.add_program_state(program_state_3);

        try
        {
            expression3.type_check(new MyDictionary<String,Type>());
            menu.add_command(new RunExample("3",expression3.toString(),controller3));

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }

        //fourth example (with files)

        ProgramState program_state_4=new ProgramState(expression4);
        Repository_Interface repository4=new Repository("log4.txt");
        Controller controller4=new Controller(repository4);
        controller4.add_program_state(program_state_4);

        try
        {
            expression4.type_check(new MyDictionary<String,Type>());
            menu.add_command(new RunExample("4",expression4.toString(),controller4));

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }


        //fifth example (with while statement)

        ProgramState program_state_5=new ProgramState(expression5);
        Repository_Interface repository5=new Repository("log5.txt");
        Controller controller5=new Controller(repository5);
        controller5.add_program_state(program_state_5);

        try
        {
            expression5.type_check(new MyDictionary<String,Type>());
            menu.add_command(new RunExample("5",expression5.toString(),controller5));

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }


        //sixth example (with heap allocation & reading, slightly altered)

        ProgramState program_state_6=new ProgramState(expression6);
        Repository_Interface repository6=new Repository("log6.txt");
        Controller controller6=new Controller(repository6);
        controller6.add_program_state(program_state_6);

        try
        {
            expression6.type_check(new MyDictionary<String,Type>());
            menu.add_command(new RunExample("6",expression6.toString(),controller6));

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }

        // seventh example (with heap writing, slightly altered)

        ProgramState program_state_7=new ProgramState(expression7);
        Repository_Interface repository7=new Repository("log7.txt");
        Controller controller7=new Controller(repository7);
        controller7.add_program_state(program_state_7);

        try
        {
            expression7.type_check(new MyDictionary<String,Type>());
            menu.add_command(new RunExample("7",expression7.toString(),controller7));

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }

        // eight example (with garbage collector, no longer throws exception because it takes into account possible references from heap cells)

        ProgramState program_state_8=new ProgramState(expression8);
        Repository_Interface repository8=new Repository("log8.txt");
        Controller controller8=new Controller(repository8);
        controller8.add_program_state(program_state_8);

        try
        {
            expression8.type_check(new MyDictionary<String,Type>());
            menu.add_command(new RunExample("8",expression8.toString(),controller8));

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }

        //ninth example (with fork from A5 PDF)
        ProgramState program_state_9=new ProgramState(expression9);
        Repository_Interface repository9=new Repository("log9.txt");
        Controller controller9=new Controller(repository9);
        controller9.add_program_state(program_state_9);
        try
        {
            expression9.type_check(new MyDictionary<String,Type>());
            menu.add_command(new RunExample("9",expression9.toString(),controller9));

        }
        catch (Exception e)
        {
            System.out.println(e.getMessage());
        }

        //tenth example (type checker, will be invalid because we are trying to assign a bool value to an int
//        ProgramState program_state_10=new ProgramState(expression10);
//        Repository_Interface repository10=new Repository("log10.txt");
//        Controller controller10=new Controller(repository10);
//        controller10.add_program_state(program_state_10);
//        try
//        {
//            expression10.type_check(new MyDictionary<String,Type>());
//            menu.add_command(new RunExample("10",expression10.toString(),controller10));
//
//        }
//        catch (Exception e)
//        {
//            System.out.println(e.getMessage());
//        }

        menu.show(); //show menu in console

    }


}
