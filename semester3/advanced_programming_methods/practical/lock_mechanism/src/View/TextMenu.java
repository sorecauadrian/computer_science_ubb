package View;

import java.util.Map;
import java.util.HashMap;
import java.util.Scanner;


public class TextMenu
{
    private Map<String,Command> commands;

    public TextMenu()
    {
        this.commands=new HashMap<String, Command>();
    }

    public void add_command(Command command)
    {
        this.commands.put(command.get_key(),command);
    }

    private void print_menu()
    {
        for(Command command:commands.values())
        {
            String line=String.format("%4s : %s",command.get_key(),command.get_description());
            System.out.println(line);
        }
    }

    public void show()
    {
        Scanner scanner=new Scanner(System.in);


        while (true)
        {
            print_menu();
            System.out.print("Give an option: ");
            String key=scanner.nextLine();
            Command command=commands.get(key);

            if(command == null)
            {
                System.out.println("Invalid option!");
                continue;

            }

            command.execute();
        }
    }

}
