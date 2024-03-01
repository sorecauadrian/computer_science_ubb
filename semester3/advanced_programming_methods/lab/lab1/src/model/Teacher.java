package model;

public class Teacher implements Participant 
{
	private String name;
	private boolean presented;
	
	public Teacher(String name, boolean presented)
	{
		this.name = name;
		this.presented = presented;
	}
	
	public String getName() {return this.name;}
	public String getRole() {return "teacher";}

	@Override
	public String toString() {return this.getRole() + ": " + this.getName() + (this.presented()? " has presented." : " has not presented.");}
	
	public boolean presented() {return this.presented;}

	public boolean equals(Object obj)
	{
		if (!(obj instanceof Teacher teacher))
			return false;
		return this.getName().equals(teacher.getName()) && this.getRole().equals(teacher.getRole()) && this.presented() == teacher.presented();
	}
}
