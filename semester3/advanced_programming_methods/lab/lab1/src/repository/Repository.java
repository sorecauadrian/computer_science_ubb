package repository;

import model.Participant;
import exceptions.*;

public class Repository implements Repository_Interface
{
	private Participant[] participants;
	private int length;
	
	public Repository()
	{
		this.participants = new Participant[32];
		this.length = 0;
	}
	
	public void add(Participant participant) throws Exception
	{
		if (this.isInList(participant))
			throw new Existence_Exception("participant already exists!\n");
		if (this.getLength() >= 32)
			throw new Capacity_Exception("maximum capacity exceeded!\n");
		this.participants[this.length++] = participant;
	}
	public void remove(Participant participant) throws Exception
	{
		if (!this.isInList(participant))
			throw new Nonexistence_Exception("participant doesn't exist!\n");
		for (int i = 0; i < this.length; i++)
			if (this.participants[i].equals(participant))
			{
				for (int j = i; j < this.length - 1; j++)
					this.participants[j] = this.participants[j + 1];
				this.participants[--this.length] = null;
				break;
			}
	}
	public int getLength() {return this.length;}
	public Participant[] getList() {return this.participants;}
	public boolean isInList(Participant participant)
	{
		for (int i = 0; i < this.length; i++)
			if (this.participants[i].equals(participant))
				return true;
		return false;
	}
}
