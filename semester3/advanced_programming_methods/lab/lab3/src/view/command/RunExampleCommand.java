package view.command;

import controller.Controller;
import exceptions.InterpreterException;
import exceptions.TypeException;

import java.util.Scanner;

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
        // step-by-step process printing
        Scanner scanner = new Scanner(System.in);
        System.out.print("do you want to show the step-by-step process? y/n ");
        String answer = scanner.nextLine();
        if (answer.equals("y"))
            this.controller.setShowAllSteps(true);
        else if (answer.equals("n"))
            this.controller.setShowAllSteps(false);
        else
            System.out.println("not a valid answer. we'll show you only the result, dumbass.");
        System.out.println();

        try {this.controller.allStep();}
        catch (TypeException exception) {System.out.println("typechecking failed: " + exception.getMessage());}
        catch (InterpreterException exception) {System.out.println(exception.getMessage());}
    }
}
