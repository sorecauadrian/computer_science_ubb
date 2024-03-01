package model;

public class Student implements Participant
{
	private String name;
	private boolean presented;
	
	public Student(String name, boolean presented)
	{
		this.name = name;
		this.presented = presented;
	}
	
	public String getName() {return this.name;}
	public String getRole() {return "student";}

	@Override
	public String toString() {return this.getRole() + ": " + this.getName() + (this.presented()? " has presented." : " has not presented.");}
	
	public boolean presented() {return this.presented;}

	public boolean equals(Object obj)
	{
		if (!(obj instanceof Student student))
			return false;
		return this.getName().equals(student.getName()) && this.getRole().equals(student.getRole()) && this.presented() == student.presented();
	}
}
