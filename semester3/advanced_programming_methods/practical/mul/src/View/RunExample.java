package View;

import Controller.Controller;
import Exceptions.*;

import java.io.IOException;

public class RunExample extends Command
{
    Controller controller;

    public RunExample(String key, String description,Controller controller)
    {
        super(key, description);
        this.controller=controller;
    }

    @Override
    public void execute()
    {
        try
        {
            this.controller.execute_all_steps();
        }
        catch (Exception error)
        {
            System.out.println(error.getMessage());
        }

    }
}
