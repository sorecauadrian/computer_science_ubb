package GUI;

import Controller.Controller;
import Model.ADTs.MyDictionary;
import Model.Expressions.*;
import Model.ProgramState.ProgramState;
import Model.Statements.*;
import Model.Types.*;
import Model.Values.IntValue;
import Repository.Repository;
import Repository.Repository_Interface;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;

import javafx.scene.control.Alert;
import javafx.event.ActionEvent;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

public class SelectWindow_Controller  implements Initializable
{
    @FXML
    private Button select_button;
    @FXML
    private ListView<Statement> selectProgramListView;

    private MainWindow_Controller mainWindowController;

    public MainWindow_Controller get_main_window_controller()
    {
        return mainWindowController;
    }

    public void set_main_window_controller(MainWindow_Controller main_window_controller)
    {
        this.mainWindowController =main_window_controller;
    }

    @FXML
    private Statement select_program(ActionEvent actionEvent)
    {
        return selectProgramListView.getItems().get(selectProgramListView.getSelectionModel().getSelectedIndex());
    }

    private List<Statement> initialise_programs()
    {
        List<Statement> statements_list=new ArrayList<>();


        Statement second_fork=new CompoundStatement(new Lock_Statement("x"),
                new CompoundStatement(new Heap_WriteStatement("v1",
                        new ArithmeticExpression(new Heap_ReadExpression(new VariableExpression("v1")),new ValueExpression(new IntValue(1)),"-")),new UnlockStatement("x")));

        Statement first_fork=new CompoundStatement(second_fork,
                new CompoundStatement(new Lock_Statement("x"),
                        new CompoundStatement(new Heap_WriteStatement("v1",new ArithmeticExpression(new Heap_ReadExpression(new VariableExpression("v1")),new ValueExpression(new IntValue(10)),"*")),
                                new UnlockStatement("x"))));

        Statement fourth_fork=new CompoundStatement(new Lock_Statement("q"),
                new CompoundStatement(new Heap_WriteStatement("v2",
                        new ArithmeticExpression(new Heap_ReadExpression(new VariableExpression("v2")),new ValueExpression(new IntValue(5)),"+")),new UnlockStatement("q")));

        Statement third_fork=new CompoundStatement(fourth_fork,
                new CompoundStatement(new Lock_Statement("q"),
                        new CompoundStatement(new Heap_WriteStatement("v2",new ArithmeticExpression(new Heap_ReadExpression(new VariableExpression("v2")),new ValueExpression(new IntValue(10)),"*")),
                                new UnlockStatement("q"))));


        Statement statement_for_lock=new CompoundStatement(new Variable_DeclarationStatement("v1",new ReferenceType(new IntType())),
                new CompoundStatement(new Variable_DeclarationStatement("v2",new ReferenceType(new IntType())),
                        new CompoundStatement(new Variable_DeclarationStatement("x",new IntType()),
                                new CompoundStatement(new Variable_DeclarationStatement("q",new IntType()),
                                        new CompoundStatement(new NewStatement("v1",new ValueExpression(new IntValue(20))),
                                                new CompoundStatement(new NewStatement("v2",new ValueExpression(new IntValue(30))),
                                                        new CompoundStatement(new New_LockStatement("x"),
                                                                new CompoundStatement(first_fork,
                                                                        new CompoundStatement(new New_LockStatement("q"),
                                                                                new CompoundStatement(third_fork,
                                                                                        new CompoundStatement(new NopStatement(),
                                                                                                new CompoundStatement(new NopStatement(),
                                                                                                        new CompoundStatement(new NopStatement(),
                                                                                                                new CompoundStatement(new Lock_Statement("x"),
                                                                                                                        new CompoundStatement(new PrintStatement(new Heap_ReadExpression(new VariableExpression("v1"))),
                                                                                                                                new CompoundStatement(new UnlockStatement("x"),
                                                                                                                                        new CompoundStatement(new Lock_Statement("q"),
                                                                                                                                                new CompoundStatement(new PrintStatement(new Heap_ReadExpression(new VariableExpression("v2"))),
                                                                                                                                                        new UnlockStatement("q")))))))))))))))))));

        Statement statement_for_for=new CompoundStatement(new Variable_DeclarationStatement("a",new ReferenceType(new IntType())),
                new CompoundStatement(new NewStatement("a",new ValueExpression(new IntValue(20))),
                        new CompoundStatement(new Variable_DeclarationStatement("x",new IntType()),
                                new CompoundStatement( new ForStatement("x",new ValueExpression(new IntValue(0)),new ValueExpression(new IntValue(3)),new ArithmeticExpression(new VariableExpression("x"),new ValueExpression(new IntValue(1)),"+"),
                                        new ForkStatement(new CompoundStatement(new PrintStatement(new VariableExpression("x")),new AssignmentStatement("x",new ArithmeticExpression(new VariableExpression("x"),new Heap_ReadExpression(new VariableExpression("a")),"*"))))),new PrintStatement(new Heap_ReadExpression(new VariableExpression("a")))))
                ));

        statements_list.add(statement_for_lock);
        statements_list.add(statement_for_for);
        return statements_list;
    }

    private void display_programs()
    {
        List<Statement> programs= initialise_programs();
        selectProgramListView.setItems(FXCollections.observableArrayList(programs));
        selectProgramListView.getSelectionModel().select(0);
        select_button.setOnAction(actionEvent -> {
            int index= selectProgramListView.getSelectionModel().getSelectedIndex();
            Statement selected_program= selectProgramListView.getItems().get(index);
            index++;
            ProgramState program_state=new ProgramState(selected_program);
            Repository_Interface repository=new Repository("log"+index+".txt");
            Controller controller=new Controller(repository);
            controller.add_program_state(program_state);
            try
            {
                selected_program.type_check(new MyDictionary<String, Type>());
                mainWindowController.set_controller(controller);
            }
            catch (Exception e)
            {
                Alert alert = new Alert(Alert.AlertType.ERROR,e.getMessage());
                alert.show();
            }


        });
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle)
    {
        display_programs();

    }


}
