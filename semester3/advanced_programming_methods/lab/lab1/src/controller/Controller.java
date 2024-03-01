package controller;

import model.Participant;
import repository.*;

public class Controller implements Controller_Interface
{
	private Repository_Interface repository; // private Repository_Interface repository
	
	public Controller() {this.repository = new Repository();}
	
	public void add(Participant participant) throws Exception {this.repository.add(participant);}
	public void remove(Participant participant) throws Exception {this.repository.remove(participant);}
	public int get_length() {return this.repository.getLength();}
	public Participant[] get_list() {return this.repository.getList();}
	public Participant[] get_filtered_list()
	{
		Participant[] participants = this.get_list();
		Participant[] filtered_participants = new Participant[32];
		int i = 0;
		for (int k = 0; k < this.get_length(); k++)
			if (participants[k].presented())
				filtered_participants[i++] = participants[k];
		return filtered_participants;
	}
}
