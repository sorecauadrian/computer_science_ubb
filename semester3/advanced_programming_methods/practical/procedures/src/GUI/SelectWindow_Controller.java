package GUI;

import Controller.Controller;
import Model.ADTs.MyDictionary;
import Model.ADTs.MyProcedureTable;
import Model.ADTs.MyProcedureTable_Interface;
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
import javafx.util.Pair;

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

    //EXAMPLE WITH SUM AS PROCEDURE--------------
    ArrayList<String> sum_parameter_list = new ArrayList<String>(){

        {
            add("a");
            add("b");
        }


    };

    Statement TwoSumS0 = new Variable_DeclarationStatement("v",new IntType());
    Statement TwoSumS1 = new AssignmentStatement("v", new ArithmeticExpression(new VariableExpression("a"), new VariableExpression("b"),"+"));
    Statement TwoSumS2 = new PrintStatement(new VariableExpression("v"));
    Statement TwoSumFinalStmt =new CompoundStatement(TwoSumS0, new CompoundStatement(TwoSumS1, TwoSumS2));
    Pair<List<String>,Statement> TwoSumPair = new Pair<List<String>,Statement>(sum_parameter_list, TwoSumFinalStmt);

    //EXAMPLE WITH PRODUCT AS PROCEDURE
    ArrayList<String> product_parameter_list = new ArrayList<>(){

        {
            add("a");
            add("b");
        }
    };

    Statement TwoProdS0 = new Variable_DeclarationStatement("v",new IntType());
    Statement TwoProdS1 = new AssignmentStatement("v", new ArithmeticExpression(new VariableExpression("a"), new VariableExpression("b"),"*"));
    Statement TwoProdS2 = new PrintStatement(new VariableExpression("v"));
    Statement TwoProdFinalStmt = new CompoundStatement(TwoProdS0, new CompoundStatement(TwoProdS1, TwoProdS2));
    Pair<List<String>,Statement> TwoProdPair = new Pair<List<String>,Statement>(product_parameter_list, TwoProdFinalStmt);

    //---------------------

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

        ArrayList<Expression> expList3 = new ArrayList<>();
        expList3.add(new VariableExpression("v"));
        expList3.add(new VariableExpression("w"));
        Statement third_procedure_call=new Call_ProcedureStatement("sum",expList3);

        ArrayList<Expression> expList = new ArrayList<>();
        expList.add(new ArithmeticExpression(new VariableExpression("v"), new ValueExpression(new IntValue(10)),"*"));
        expList.add(new VariableExpression("w"));
        Statement first_procedure_call=new Call_ProcedureStatement("sum",expList);
        Statement second_procedure_call=new Call_ProcedureStatement("product",expList3);

        Statement statement_for_procedure=new CompoundStatement(new Variable_DeclarationStatement("v",new IntType()),
                new CompoundStatement(new Variable_DeclarationStatement("w",new IntType()),
                        new CompoundStatement(new AssignmentStatement("v",new ValueExpression(new IntValue(2))),
                                new CompoundStatement(new AssignmentStatement("w",new ValueExpression(new IntValue(5))),
                                        new CompoundStatement(first_procedure_call,
                                                new CompoundStatement(new PrintStatement(new VariableExpression("v")),
                                                    new ForkStatement(new CompoundStatement(second_procedure_call,new ForkStatement(third_procedure_call)))))))));




        statements_list.add(statement_for_procedure);
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

            //new addition for procedures, this procedures will be present in all programs
            MyProcedureTable_Interface<Pair<List<String>,Statement>> procedure_table=new MyProcedureTable<Pair<List<String>, Statement>>();
            procedure_table.put("sum", TwoSumPair);
            procedure_table.put("product", TwoProdPair);
            program_state.set_procedure_table(procedure_table);
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
