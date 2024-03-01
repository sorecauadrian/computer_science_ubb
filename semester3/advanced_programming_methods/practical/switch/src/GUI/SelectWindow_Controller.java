package GUI;

import Controller.Controller;
import Model.ADTs.MyDictionary;
import Model.Expressions.*;
import Model.ProgramState.ProgramState;
import Model.Statements.*;
import Model.Types.*;
import Model.Values.BoolValue;
import Model.Values.IntValue;
import Model.Values.StringValue;
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
    private ListView<Statement> select_programs_list_view;

    private MainWindow_Controller main_window_controller;

    public MainWindow_Controller get_main_window_controller()
    {
        return main_window_controller;
    }

    public void set_main_window_controller(MainWindow_Controller main_window_controller)
    {
        this.main_window_controller=main_window_controller;
    }

    @FXML
    private Statement select_program(ActionEvent actionEvent)
    {
        return select_programs_list_view.getItems().get(select_programs_list_view.getSelectionModel().getSelectedIndex());
    }

    private List<Statement> initialise_programs()
    {
        List<Statement> statements_list=new ArrayList<>();

        Statement statement_for_switch=new CompoundStatement(new Variable_DeclarationStatement("a",new IntType()),
                new CompoundStatement(new Variable_DeclarationStatement("b",new IntType()),
                        new CompoundStatement(new Variable_DeclarationStatement("c",new IntType()),
                                new CompoundStatement(new AssignmentStatement("a",new ValueExpression(new IntValue(1))),
                                        new CompoundStatement(new AssignmentStatement("b",new ValueExpression(new IntValue(2))),
                                                new CompoundStatement(new AssignmentStatement("c",new ValueExpression(new IntValue(5))),
                                                        new CompoundStatement(new SwitchStatement(new ArithmeticExpression("*",new VariableExpression("a"),new ValueExpression(new IntValue(10))),
                                                                new ArithmeticExpression("*",new VariableExpression("b"),new VariableExpression("c")),
                                                                new ValueExpression(new IntValue(10)),new CompoundStatement(new PrintStatement(new VariableExpression("a")),new PrintStatement(new VariableExpression("b"))),
                                                                new CompoundStatement(new PrintStatement(new ValueExpression(new IntValue(100))),new PrintStatement(new ValueExpression(new IntValue(200)))),new PrintStatement(new ValueExpression(new IntValue(300)))),new PrintStatement(new ValueExpression(new IntValue(300))))))))));

        statements_list.add(statement_for_switch);
        return statements_list;
    }

    private void display_programs()
    {
        List<Statement> programs= initialise_programs();
        select_programs_list_view.setItems(FXCollections.observableArrayList(programs));
        select_programs_list_view.getSelectionModel().select(0);
        select_button.setOnAction(actionEvent -> {
            int index=select_programs_list_view.getSelectionModel().getSelectedIndex();
            Statement selected_program=select_programs_list_view.getItems().get(index);
            index++;
            ProgramState program_state=new ProgramState(selected_program);
            Repository_Interface repository=new Repository("log"+index+".txt");
            Controller controller=new Controller(repository);
            controller.add_program_state(program_state);
            try
            {
                selected_program.type_check(new MyDictionary<String, Type>());
                main_window_controller.set_controller(controller);
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
