package view;

import model.*;
import controller.*;

import java.util.Scanner;

public class View implements View_Interface
{
    private Controller_Interface controller = new Controller();
    private Scanner scanner = new Scanner(System.in);

    public void menu()
    {
        System.out.println("menu");
        System.out.println("1. add a new participant");
        System.out.println("2. remove a participant");
        System.out.println("3. print all the participants that presented");
        System.out.println("4. print all the participants");
        System.out.println("5. populate the list");
        System.out.println("0. exit");
    }

    public void add_menu()
    {
        System.out.println("add");
        System.out.println("1. student");
        System.out.println("2. teacher");
        System.out.println("3. specialist");
    }

    public void remove_menu()
    {
        System.out.println("remove");
        System.out.println("1. student");
        System.out.println("2. teacher");
        System.out.println("3. specialist");
    }

    public void add_participant() throws Exception
    {
        this.add_menu();

        int option = Integer.parseInt(this.scanner.nextLine());
        System.out.println("the name of the new participant:");
        String name = this.scanner.nextLine();
        System.out.println("did the participant present? true|false");
        boolean presented = Boolean.parseBoolean(this.scanner.nextLine());

        if (option == 1)
            this.controller.add(new Student(name, presented));
        else if (option == 2)
            this.controller.add(new Teacher(name, presented));
        else if (option == 3)
            this.controller.add(new Specialist(name, presented));
        else
            System.out.println("unknown command.");
        System.out.println();
    }

    public void remove_participant() throws Exception
    {
        this.remove_menu();

        int option = Integer.parseInt(this.scanner.nextLine());
        System.out.println("the name of the participant:");
        String name = this.scanner.nextLine();
        System.out.println("did the participant present? true|false");
        boolean presented = Boolean.parseBoolean(this.scanner.nextLine());

        if (option == 1)
            this.controller.remove(new Student(name, presented));
        else if (option == 2)
            this.controller.remove(new Teacher(name, presented));
        else if (option == 3)
            this.controller.remove(new Specialist(name, presented));
        else
            System.out.println("unknown command.");
        System.out.println();
    }

    public void print_filtered_participants()
    {
        for (Participant participant : this.controller.get_filtered_list())
            if (participant != null)
                System.out.println(participant);
        System.out.println();
    }

    public void print_participants()
    {
        for (Participant participant : this.controller.get_list())
            if (participant != null)
                System.out.println(participant);
        System.out.println();
    }
    public void premade_list() throws Exception
    {
        this.controller.add(new Student("adi", true));
        this.controller.add(new Teacher("vancea", true));
        this.controller.add(new Student("rudolf", false));
        this.controller.add(new Specialist("suciu dan mircea", true));
        this.controller.add(new Teacher("dadi", false));
        this.controller.add(new Specialist("arthur", false));
    }

    public void run()
    {
        while (true)
        {
            try
            {
                this.menu();
                int option = Integer.parseInt(this.scanner.nextLine());
                if (option == 1)
                    this.add_participant();
                else if (option == 2)
                    this.remove_participant();
                else if (option == 3)
                    this.print_filtered_participants();
                else if (option == 4)
                    this.print_participants();
                else if (option == 5)
                    this.premade_list();
                else if (option == 0)
                    break;
                else
                    System.out.println("unknown command.\n");
            }
            catch (NumberFormatException nfe)
            {
                System.out.println("unknown command.\n");
            }
            catch (Exception e)
            {
                System.out.println(e.getMessage());
            }
        }
    }
}
