import controller.Controller;
import model.ProgramState;
import model.adts.MyDictionary;
import model.adts.MyList;
import model.adts.MyStack;
import model.expressions.ArithmeticExpression;
import model.expressions.LogicExpression;
import model.expressions.ValueExpression;
import model.expressions.VariableExpression;
import model.statements.*;
import model.types.BoolType;
import model.types.IntType;
import model.values.BoolValue;
import model.values.IntValue;
import repository.Repository;
import repository.RepositoryInterface;
import view.Menu;
import view.command.ExitCommand;
import view.command.RunExampleCommand;

public class Main
{
    private static final Statement example1;
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
    }
    private static final Statement example2;
    static
    {
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
    }

    private static final Statement example3;
    static
    {
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
    }

    private static final Statement example4;
    static
    {
        example4 = new PrintStatement(new LogicExpression("or", new ValueExpression(new BoolValue(true)), new ValueExpression(new BoolValue(false))));
    }

    public static void main(String[] args)
    {
        ProgramState state1, state2, state3, state4;
        Controller controller1, controller2, controller3, controller4;

        state1 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), example1);
        RepositoryInterface repository1 = new Repository();
        repository1.addState(state1);
        controller1 = new Controller(repository1);

        state2 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), example2);
        RepositoryInterface repository2 = new Repository();
        repository2.addState(state2);
        controller2 = new Controller(repository2);

        state3 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), example3);
        RepositoryInterface repository3 = new Repository();
        repository3.addState(state3);
        controller3 = new Controller(repository3);

        state4 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), example4);
        RepositoryInterface repository4 = new Repository();
        repository4.addState(state4);
        controller4 = new Controller(repository4);

        Menu menu = new Menu();
        menu.addCommand(new ExitCommand("0", "exit"));
        menu.addCommand(new RunExampleCommand("1", example1.toString(), controller1));
        menu.addCommand(new RunExampleCommand("2", example2.toString(), controller2));
        menu.addCommand(new RunExampleCommand("3", example3.toString(), controller3));
        menu.addCommand(new RunExampleCommand("4", example4.toString(), controller4));

        menu.show();
    }
}