package controller;

import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyStackInterface;
import model.statements.Statement;
import repository.RepositoryInterface;

public class Controller
{
    private final RepositoryInterface repository;
    private boolean showAllSteps;
    public Controller(RepositoryInterface repo)
    {
        this.repository = repo;
        this.showAllSteps = true;
    }
    public ProgramState oneStep(ProgramState state) throws InterpreterException
    {
        MyStackInterface<Statement> stack = state.getStack();
        if (stack.isEmpty()) throw new InterpreterException("program state stack is empty");
        Statement currentStatement = stack.pop();
        return currentStatement.execute(state);
    }

    public void allStep() throws InterpreterException
    {
        ProgramState programState = this.repository.getCurrentProgram();
        System.out.println(programState.toString());
        while (!programState.getStack().isEmpty())
        {
            this.oneStep(programState);
            System.out.println(programState);
        }
    }

    public void outputAfterAllStep() throws InterpreterException
    {
        ProgramState programState = this.repository.getCurrentProgram();
        while (!programState.getStack().isEmpty())
            this.oneStep(programState);
        System.out.println(programState.getList());
    }

    public boolean getShowAllSteps() {return this.showAllSteps;}
    public void setShowAllSteps(boolean showAllSteps) {this.showAllSteps = showAllSteps;}
}
