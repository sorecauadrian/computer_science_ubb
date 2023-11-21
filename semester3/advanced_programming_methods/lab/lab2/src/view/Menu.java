package view;

import view.command.Command;
import view.command.RunExampleCommand;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Menu
{
    private final Map<String, Command> commandMap;
    public Menu() {this.commandMap = new HashMap<>();}
    public void addCommand(Command command) {this.commandMap.put(command.getKey(), command);}
    private void printMenu()
    {
        for (Command command : this.commandMap.values())
        {
            String line = String.format("%s: %s", command.getKey(), command.getDescription());
            System.out.println(line);
        }
        System.out.println("every example can be run only once");
    }

    public void show()
    {
        Scanner scanner = new Scanner(System.in);
        while (true)
        {
            printMenu();
            System.out.print("enter your command: ");
            String key = scanner.nextLine();
            Command command = this.commandMap.get(key);
            if (command == null)
            {
                System.out.println("invalid option");
                continue;
            }
            if (command instanceof RunExampleCommand runCommand)
            {
                System.out.println("do you want to show the step by step execution? y/n");
                String answer = scanner.nextLine();
                runCommand.getController().setShowAllSteps(answer.equals("y"));
            }
            command.execute();
            if (commandMap.isEmpty())
                break;
        }
    }
}
