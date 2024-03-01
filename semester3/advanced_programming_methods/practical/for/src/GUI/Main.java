package GUI;
import javafx.application.Application;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;


public class Main extends Application
{

    public static void main(String[] args)
    {
        launch(args);
    }
    @Override
    public void start(Stage primaryStage) throws IOException
    {
        FXMLLoader main_loader = new FXMLLoader();
        main_loader.setLocation(getClass().getResource("MainWindow.fxml"));
        Parent main_window=main_loader.load();

        MainWindow_Controller main_window_controller=main_loader.getController();

        primaryStage.setTitle("Main Window");
        primaryStage.setScene(new Scene(main_window,1000,800));
        primaryStage.show();

        FXMLLoader secondary_loader=new FXMLLoader();
        secondary_loader.setLocation(getClass().getResource("SelectWindow.fxml"));
        Parent secondary_window=secondary_loader.load();
        SelectWindow_Controller selectWindow_controller=secondary_loader.getController();
        selectWindow_controller.set_main_window_controller(main_window_controller);

        Stage secondaryStage=new Stage();
        secondaryStage.setTitle("Select Window");
        secondaryStage.setScene(new Scene(secondary_window,600,650));
        secondaryStage.show();



    }
}
