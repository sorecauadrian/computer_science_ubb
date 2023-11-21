package repository;

import model.ProgramState;

import java.util.List;

public interface RepositoryInterface
{
    ProgramState getCurrentProgram();
    void addState(ProgramState state);
    List<ProgramState> getProgramList();
    void setProgramList(List<ProgramState> programStateList);
}
