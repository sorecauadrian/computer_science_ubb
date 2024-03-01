package repository;

import exceptions.FileException;
import exceptions.InterpreterException;
import model.ProgramState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

public class Repository implements RepositoryInterface
{
    private final List<ProgramState> programStates;
    private final String logFilePath;

    public Repository(String filePath)
    {
        this.programStates = new LinkedList<>();
        this.logFilePath = filePath;
    }

    public void logPrgStateExec(ProgramState state) throws InterpreterException
    {
        PrintWriter logFile;
        try {logFile = new PrintWriter(new BufferedWriter(new FileWriter(this.logFilePath, true)));}
        catch (IOException exception) {throw new FileException(exception.getMessage());}
        logFile.println(state.toString());
        logFile.flush();
        if (state.getExecutionStack().isEmpty())
        {
            logFile.close();
        }
    }

    @Override
    public ProgramState getCurrentProgram()
    {
        ProgramState current = this.programStates.get(0);
        this.programStates.removeFirst();
        return current;
    }
    @Override
    public void addState(ProgramState state) {this.programStates.add(state);}

}
