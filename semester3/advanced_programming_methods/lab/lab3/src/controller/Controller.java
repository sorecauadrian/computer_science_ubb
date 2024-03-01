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
        this.showAllSteps = false;
    }

    @SuppressWarnings("UnusedReturnValue")
    public ProgramState oneStep(ProgramState state) throws InterpreterException
    {
        MyStackInterface<Statement> stack = state.getExecutionStack();
        if (stack.isEmpty()) throw new InterpreterException("program state stack is empty");
        Statement currentStatement = stack.pop();
        return currentStatement.execute(state);
    }

    public void allStep() throws InterpreterException
    {
        ProgramState programState = this.repository.getCurrentProgram();
        if (this.getShowAllSteps())
            this.repository.logPrgStateExec(programState);
        while (!programState.getExecutionStack().isEmpty())
        {
            this.oneStep(programState);
            if (this.getShowAllSteps())
                this.repository.logPrgStateExec(programState);
        }
        if (!this.getShowAllSteps())
            this.repository.logPrgStateExec(programState);
    }

    public boolean getShowAllSteps() {return this.showAllSteps;}
    public void setShowAllSteps(boolean showAllSteps) {this.showAllSteps = showAllSteps;}
}
