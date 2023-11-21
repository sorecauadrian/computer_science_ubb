package view.command;

import controller.Controller;
import exceptions.InterpreterException;
import exceptions.TypeException;

public class RunExampleCommand extends Command
{
    private final Controller controller;

    public RunExampleCommand(String k, String d, Controller c)
    {
        super(k, d);
        this.controller = c;
    }

    @Override
    public void execute()
    {
        try
        {
            if (this.controller.getShowAllSteps())
                this.controller.allStep();
            else
                this.controller.outputAfterAllStep();
        }
        catch (TypeException exception) {
            System.out.println("typechecking failed: " + exception.getMessage());
        }
        catch (InterpreterException exception) {
            System.out.println(exception.getMessage());
        }
    }

    public Controller getController() {return this.controller;}
}
