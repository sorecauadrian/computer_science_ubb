package model;

public class Specialist implements Participant
{
	private String name;
	private boolean presented;
	
	public Specialist(String name, boolean presented)
	{
		this.name = name;
		this.presented = presented;
	}
	
	public String getName() {return this.name;}
	public String getRole() {return "specialist";}

	@Override
	public String toString() {return this.getRole() + ": " + this.getName() + (this.presented()? " has presented." : " has not presented.");}
	
	public boolean presented() {return this.presented;}

	public boolean equals(Object obj)
	{
		if (!(obj instanceof Specialist specialist))
			return false;
		return this.getName().equals(specialist.getName()) && this.getRole().equals(specialist.getRole()) && this.presented() == specialist.presented();
	}
}
