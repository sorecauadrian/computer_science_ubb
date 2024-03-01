package repository;

import model.Participant;

public interface Repository_Interface 
{
	public void add(Participant participant) throws Exception;
	public void remove(Participant participant) throws Exception;
	public int getLength();
	public Participant[] getList();
	public boolean isInList(Participant participant);
}
