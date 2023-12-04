import controller.Controller;
import model.ProgramState;
import model.adts.MyDictionary;
import model.adts.MyHeap;
import model.adts.MyList;
import model.adts.MyStack;
import model.expressions.*;
import model.statements.*;
import model.types.BoolType;
import model.types.IntType;
import model.types.ReferenceType;
import model.types.StringType;
import model.values.BoolValue;
import model.values.IntValue;
import model.values.StringValue;
import repository.Repository;
import repository.RepositoryInterface;
import view.Menu;
import view.command.ExitCommand;
import view.command.RunExampleCommand;

public class Main
{
    private static final Statement example1, example2, example3, example4, example5, example6;
    static
    {
        // int a;
        // int b;
        // a = 2 + 3 * 5;
        // b = a + 1;
        // print(b)
        example1 = new CompoundStatement
        (
                new VariableDeclarationStatement("a", new IntType()),
                new CompoundStatement
                (
                        new VariableDeclarationStatement("b", new IntType()),
                        new CompoundStatement
                        (
                                new AssignmentStatement("a", new ArithmeticExpression('+', new ValueExpression(new IntValue(2)), new ArithmeticExpression('*', new ValueExpression(new IntValue(3)), new ValueExpression(new IntValue(5))))),
                                new CompoundStatement
                                (
                                        new AssignmentStatement("b", new ArithmeticExpression('+', new VariableExpression("a"), new ValueExpression(new IntValue(1)))),
                                        new PrintStatement(new VariableExpression("b"))
                                )

                        )
                )
        );

        // bool a;
        // int v;
        // a = true;
        // if a then v = 2 else v = 3
        // print(v)
        example2 = new CompoundStatement
        (
                new VariableDeclarationStatement("a", new BoolType()),
                new CompoundStatement
                (
                        new VariableDeclarationStatement("v", new IntType()),
                        new CompoundStatement
                        (
                                new AssignmentStatement("a", new ValueExpression(new BoolValue(true))),
                                new CompoundStatement
                                (
                                        new IfStatement(new VariableExpression("a"), new AssignmentStatement("v", new ValueExpression(new IntValue(2))), new AssignmentStatement("v", new ValueExpression(new IntValue(3)))),
                                        new PrintStatement(new VariableExpression("v"))
                                )
                        )
                )
        );

        // logic and relational expressions, nop and print statements
        // print(true or false)
        // print(true and false)
        // nop
        // print(14 == 14)
        // print(14 != 14)
        // print(14 >= 14)
        // print(14 >= 28)
        // print(14 > 28)
        // print(14 <= 14)
        // print(14 <= 28)
        // print(14 < 28)
        example3 = new CompoundStatement
        (
                    new PrintStatement(new LogicExpression("or", new ValueExpression(new BoolValue(true)), new ValueExpression(new BoolValue(false)))),
                    new CompoundStatement
                    (
                            new PrintStatement(new LogicExpression("and", new ValueExpression(new BoolValue(true)), new ValueExpression(new BoolValue(false)))),
                            new CompoundStatement
                            (
                                    new NOP(),
                                    new CompoundStatement
                                    (
                                            new PrintStatement(new RelationalExpression("==", new ValueExpression(new IntValue(14)), new ValueExpression(new IntValue(14)))),
                                            new CompoundStatement
                                            (
                                                    new PrintStatement(new RelationalExpression("!=", new ValueExpression(new IntValue(14)), new ValueExpression(new IntValue(14)))),
                                                    new CompoundStatement
                                                    (
                                                            new PrintStatement(new RelationalExpression(">=", new ValueExpression(new IntValue(14)), new ValueExpression(new IntValue(14)))),
                                                            new CompoundStatement
                                                            (
                                                                    new PrintStatement(new RelationalExpression(">=", new ValueExpression(new IntValue(14)), new ValueExpression(new IntValue(28)))),
                                                                    new CompoundStatement
                                                                    (
                                                                            new PrintStatement(new RelationalExpression(">", new ValueExpression(new IntValue(14)), new ValueExpression(new IntValue(28)))),
                                                                            new CompoundStatement
                                                                            (
                                                                                    new PrintStatement(new RelationalExpression("<=", new ValueExpression(new IntValue(14)), new ValueExpression(new IntValue(14)))),
                                                                                    new CompoundStatement
                                                                                    (
                                                                                            new PrintStatement(new RelationalExpression("<=", new ValueExpression(new IntValue(14)), new ValueExpression(new IntValue(28)))),
                                                                                            new PrintStatement(new RelationalExpression("<", new ValueExpression(new IntValue(14)), new ValueExpression(new IntValue(28))))
                                                                                    )
                                                                            )
                                                                    )
                                                            )
                                                    )
                                            )
                                    )
                            )

                    )

        );

        // string varf;
        // varf = "test.in"
        // openReadFile(varf)
        // int varc;
        // readFile(varf, varc);
        // print(varc)
        // readFile(varf, varc);
        // print(varc)
        // closeReadFile(varf);

        // test.in
        // 15
        // 50
        example4 = new CompoundStatement
        (
                new VariableDeclarationStatement("varf", new StringType()),
                new CompoundStatement
                (
                        new AssignmentStatement("varf", new ValueExpression(new StringValue("/home/sorecauadrian/computer_science/semester3/advanced_programming_methods/lab/lab3/test.in"))),
                        new CompoundStatement
                        (
                                new OpenReadFileStatement(new VariableExpression("varf")),
                                new CompoundStatement
                                (
                                        new VariableDeclarationStatement("varc", new IntType()),
                                        new CompoundStatement
                                        (
                                                new ReadFileStatement(new VariableExpression("varf"), "varc"),
                                                new CompoundStatement
                                                (
                                                        new PrintStatement(new VariableExpression("varc")),
                                                        new CompoundStatement
                                                        (
                                                                new ReadFileStatement(new VariableExpression("varf"), "varc"),
                                                                new CompoundStatement
                                                                (
                                                                        new PrintStatement(new VariableExpression("varc")),
                                                                        new CloseReadFileStatement(new VariableExpression("varf"))
                                                                )
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );

        // reference int v;
        // new(v, 20)
        // print(readHeap(v))
        // writeHeap(v, 30)
        // new(v, 20)
        // print(readHeap(v) + 5)

        example5 = new CompoundStatement
        (
                new VariableDeclarationStatement("v", new ReferenceType(new IntType())),
                new CompoundStatement
                (
                        new AllocateHeapStatement("v", new ValueExpression(new IntValue(20))),
                        new CompoundStatement
                        (
                                new PrintStatement(new ReadHeapExpression(new VariableExpression("v"))),
                                new CompoundStatement
                                (
                                        new WriteHeapStatement("v", new ValueExpression(new IntValue(30))),
                                        new CompoundStatement
                                        (
                                                new AllocateHeapStatement("v", new ValueExpression(new IntValue(20))),
                                                new PrintStatement(new ArithmeticExpression('+', new ReadHeapExpression(new VariableExpression("v")), new ValueExpression(new IntValue(5))))
                                        )

                                )
                        )
                )
        );

        // int a;
        // int b; -> implicitly 0
        // a = 5;
        // while (a > 0) a = a - 1; b = b + 2
        // print(b)
        example6 = new CompoundStatement
        (
                new VariableDeclarationStatement("a", new IntType()),
                new CompoundStatement
                (
                        new VariableDeclarationStatement("b", new IntType()),
                        new CompoundStatement
                        (
                                new AssignmentStatement("a", new ValueExpression(new IntValue(5))),
                                new CompoundStatement
                                (
                                        new WhileStatement(new RelationalExpression(">", new VariableExpression("a"), new ValueExpression(new IntValue(0))), new CompoundStatement(new AssignmentStatement("a", new ArithmeticExpression('-', new VariableExpression("a"), new ValueExpression(new IntValue(1)))), new AssignmentStatement("b", new ArithmeticExpression('+', new VariableExpression("b"), new ValueExpression(new IntValue(2)))))),
                                        new PrintStatement(new VariableExpression("b"))
                                )
                        )
                )
        );
    }

    public static void main(String[] args)
    {
        ProgramState state1, state2, state3, state4, state5, state6;
        Controller controller1, controller2, controller3, controller4, controller5, controller6;

        state1 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example1);
        RepositoryInterface repository1 = new Repository("log1.txt");
        repository1.addState(state1);
        controller1 = new Controller(repository1);

        state2 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example2);
        RepositoryInterface repository2 = new Repository("log2.txt");
        repository2.addState(state2);
        controller2 = new Controller(repository2);

        state3 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example3);
        RepositoryInterface repository3 = new Repository("log3.txt");
        repository3.addState(state3);
        controller3 = new Controller(repository3);

        state4 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example4);
        RepositoryInterface repository4 = new Repository("log4.txt");
        repository4.addState(state4);
        controller4 = new Controller(repository4);

        state5 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example5);
        RepositoryInterface repository5 = new Repository("log5.txt");
        repository5.addState(state5);
        controller5 = new Controller(repository5);

        state6 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example6);
        RepositoryInterface repository6 = new Repository("log6.txt");
        repository6.addState(state6);
        controller6 = new Controller(repository6);

        Menu menu = new Menu();
        menu.addCommand(new ExitCommand("0", "exit"));
        menu.addCommand(new RunExampleCommand("1", example1.toString(), controller1));
        menu.addCommand(new RunExampleCommand("2", example2.toString(), controller2));
        menu.addCommand(new RunExampleCommand("3", example3.toString(), controller3));
        menu.addCommand(new RunExampleCommand("4", example4.toString(), controller4));
        menu.addCommand(new RunExampleCommand("5", example5.toString(), controller5));
        menu.addCommand(new RunExampleCommand("6", example6.toString(), controller6));

        menu.show();
    }
}