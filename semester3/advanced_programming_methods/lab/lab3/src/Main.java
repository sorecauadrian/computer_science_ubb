import controller.Controller;
import model.ProgramState;
import model.adts.MyDictionary;
import model.adts.MyList;
import model.adts.MyStack;
import model.expressions.*;
import model.statements.*;
import model.types.BoolType;
import model.types.IntType;
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
    private static final Statement example1, example2, example3, example4, example5;
    static
    {
        example1 = new CompoundStatement
        (
                new VariableDeclarationStatement("v", new IntType()),
                new CompoundStatement
                        (
                                new AssignmentStatement("v", new ValueExpression(new IntValue(2))),
                                new PrintStatement(new VariableExpression("v"))
                        )
        );
        example2 = new CompoundStatement
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
        example3 = new CompoundStatement
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
        example4 = new CompoundStatement
        (
                    new PrintStatement(new LogicExpression("or", new ValueExpression(new BoolValue(true)), new ValueExpression(new BoolValue(false)))),
                    new PrintStatement(new RelationalExpression(">", new ValueExpression(new IntValue(14)), new ValueExpression(new IntValue(28))))
        );
        example5 = new CompoundStatement
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
    }

    public static void main(String[] args)
    {
        ProgramState state1, state2, state3, state4, state5;
        Controller controller1, controller2, controller3, controller4, controller5;

        state1 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), example1);
        RepositoryInterface repository1 = new Repository("log1.txt");
        repository1.addState(state1);
        controller1 = new Controller(repository1);

        state2 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), example2);
        RepositoryInterface repository2 = new Repository("log2.txt");
        repository2.addState(state2);
        controller2 = new Controller(repository2);

        state3 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), example3);
        RepositoryInterface repository3 = new Repository("log3.txt");
        repository3.addState(state3);
        controller3 = new Controller(repository3);

        state4 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), example4);
        RepositoryInterface repository4 = new Repository("log4.txt");
        repository4.addState(state4);
        controller4 = new Controller(repository4);

        state5 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), example5);
        RepositoryInterface repository5 = new Repository("log5.txt");
        repository5.addState(state5);
        controller5 = new Controller(repository5);

        Menu menu = new Menu();
        menu.addCommand(new ExitCommand("0", "exit"));
        menu.addCommand(new RunExampleCommand("1", example1.toString(), controller1));
        menu.addCommand(new RunExampleCommand("2", example2.toString(), controller2));
        menu.addCommand(new RunExampleCommand("3", example3.toString(), controller3));
        menu.addCommand(new RunExampleCommand("4", example4.toString(), controller4));
        menu.addCommand(new RunExampleCommand("5", example5.toString(), controller5));

        menu.show();
    }
}