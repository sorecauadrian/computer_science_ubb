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
//                )
//        );

        statements_list.add(expression1);
        statements_list.add(expression2);
        statements_list.add(expression3);
        statements_list.add(expression4);
        statements_list.add(expression5);
        statements_list.add(expression6);
        statements_list.add(expression7);
        statements_list.add(expression8);
        statements_list.add(expression9);
        //statements_list.add(expression10);
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
