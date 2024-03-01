package view;

public interface View_Interface 
{
	public void menu();
	public void add_menu();
	public void remove_menu();
	public void print_filtered_participants();
	public void add_participant() throws Exception;
	public void remove_participant() throws Exception;
	public void premade_list() throws Exception;
	public void run();
}
