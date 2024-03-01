package GUI;

import Controller.Controller;
import Model.ADTs.MyStack_Interface;
import Model.ProgramState.ProgramState;
import Model.Statements.Statement;
import Model.Values.Value;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;

import javafx.event.ActionEvent;
import java.net.URL;
import java.util.*;
import java.util.stream.Collectors;

public class MainWindow_Controller implements Initializable
{
    @FXML
    private ListView<String> execution_stack_view;
    @FXML
    private TableView<Map.Entry<String, Value>> symbol_table_view;
    @FXML
    private TableColumn<Map.Entry<String,Value>,String> symbol_table_names;
    @FXML
    private TableColumn<Map.Entry<String,Value>,String> symbol_table_values;
    @FXML
    private ListView<String> output_view;
    @FXML
    private ListView<String> file_table_view;
    @FXML
    private TableView<Map.Entry<Integer,Value>> heap_table_view;
    @FXML
    private TableColumn<Map.Entry<Integer,Value>,Integer> heap_table_addresses;
    @FXML
    private TableColumn<Map.Entry<Integer,Value>,String> heap_table_values;

    @FXML
    private Label program_states_counter;
    @FXML
    private Button execute_button;
    @FXML
    private ListView<Integer> program_id_view;

    private Controller controller;

    public Controller get_controller()
    {
        return this.controller;
    }

    public void set_controller(Controller controller)
    {
        this.controller=controller;
        populate_program_states_counter();
        populate_id_view();
        execute_button.setDisable(false);
    }


    @Override
    public void initialize(URL url, ResourceBundle resourceBundle)
    {
        this.controller=null;

        heap_table_addresses.setCellValueFactory(p->new SimpleIntegerProperty(p.getValue().getKey()).asObject());
        heap_table_values.setCellValueFactory(p->new SimpleStringProperty(p.getValue().getValue() + " "));

        symbol_table_names.setCellValueFactory(p->new SimpleStringProperty(p.getValue().getKey() + " "));
        symbol_table_values.setCellValueFactory(p->new SimpleStringProperty(p.getValue().getValue() + " "));

        program_id_view.setOnMouseClicked(mouseEvent -> change_program_state_handler(get_selected_program()));

        execute_button.setDisable(true);
    }

    private void change_program_state_handler(ProgramState current_program_state)
    {
        if(current_program_state==null)
        {
            return;
        }
        try
        {
            populate_program_states_counter();
            populate_id_view();
            populate_heap_table_view(current_program_state);
            populate_output_view(current_program_state);
            populate_file_table_view(current_program_state);
            populate_execution_stack_view(current_program_state);
            populate_symbol_table_view(current_program_state);
        }
        catch (Exception e)
        {
            Alert error=new Alert(Alert.AlertType.ERROR,e.getMessage());
            error.show();
        }
    }

    public void execute_one_step_handler(ActionEvent actionEvent)
    {
        if(controller==null)
        {
            Alert error=new Alert(Alert.AlertType.ERROR,"No Program Selected!");
            error.show();
            execute_button.setDisable(true);
            return;
        }

        ProgramState program_state=get_selected_program();
        if(program_state!=null && !program_state.is_not_completed())
        {
            Alert error=new Alert(Alert.AlertType.ERROR,"Nothing To Execute!");
            error.show();
            return;
        }

        try
        {
            controller.execute_one_step_for_all_programs();
            change_program_state_handler(program_state);

            if(controller.get_repository().get_program_states_list().isEmpty())
            {
                execute_button.setDisable(true);
            }
        }
        catch (InterruptedException e)
        {
            Alert error=new Alert(Alert.AlertType.ERROR,e.getMessage());
            error.show();
        }
    }

    private void populate_program_states_counter()
    {
        program_states_counter.setText("Number of Program States: "+controller.get_repository().get_program_states_list().size());
    }

    private void populate_heap_table_view(ProgramState program)
    {
        heap_table_view.setItems(FXCollections.observableList(new ArrayList<>(program.get_heap().get_content().entrySet())));
        heap_table_view.refresh();

    }

    private void populate_output_view(ProgramState program) throws Exception
    {
        output_view.setItems(FXCollections.observableArrayList(program.get_output().get_content()));
    }

    public void populate_file_table_view(ProgramState program)
    {
        file_table_view.setItems(FXCollections.observableArrayList(program.get_file_table().get_content().keySet()));
    }

    private void populate_id_view()
    {
        program_id_view.setItems(FXCollections.observableArrayList(controller.get_repository().get_program_states_list().stream().map(ProgramState::get_id).collect(Collectors.toList())));
        program_id_view.refresh();
    }

    private void populate_execution_stack_view(ProgramState program)
    {
        MyStack_Interface<Statement> stack=program.get_execution_stack();
        List<String> stack_output=new ArrayList<>();

        for(Statement statement:stack.get_values())
        {
            stack_output.add(statement.toString());
        }

        Collections.reverse(stack_output);
        execution_stack_view.setItems(FXCollections.observableArrayList(stack_output));
    }

    private void populate_symbol_table_view(ProgramState program)
    {
        symbol_table_view.setItems(FXCollections.observableList(new ArrayList<>(program.get_symbol_table().get_content().entrySet())));
        symbol_table_view.refresh();
    }

    private ProgramState get_selected_program()
    {
        // running the program even if there is no program selected
        int id;
        if(program_id_view.getSelectionModel().getSelectedIndex()==-1)
            id = controller.get_repository().get_program_states_list().stream().map(ProgramState::get_id).toList().getFirst();
        else
            id = program_id_view.getSelectionModel().getSelectedItem();

        return controller.get_repository().get_program_by_id(id);
    }



}
