package repository;

import model.ProgramState;

import java.util.LinkedList;
import java.util.List;

public class Repository implements RepositoryInterface
{
    private List<ProgramState> programStates;

    public Repository() {this.programStates = new LinkedList<>();}

    @Override
    public ProgramState getCurrentProgram()
    {
        ProgramState current = this.programStates.get(0);
        this.programStates.removeFirst();
        return current;
    }
    @Override
    public void addState(ProgramState state) {this.programStates.add(state);}

    @Override
    public List<ProgramState> getProgramList() {return this.programStates;}

    @Override
    public void setProgramList(List<ProgramState> programStateList) {this.programStates = programStateList;}
}
