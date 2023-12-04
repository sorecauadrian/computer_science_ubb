package controller;

import exceptions.InterpreterException;
import model.ProgramState;
import model.adts.MyStackInterface;
import model.statements.Statement;
import model.values.ReferenceValue;
import model.values.Value;
import repository.RepositoryInterface;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Controller
{
    private final RepositoryInterface repository;
    private boolean showAllSteps;
    public Controller(RepositoryInterface repo)
    {
        this.repository = repo;
        this.showAllSteps = false;
    }

    Map<Integer, Value> garbageCollector(List<Integer> symbolTableAddresses, Map<Integer, Value> heap)
    {
        return heap.entrySet().stream()
                .filter(e -> symbolTableAddresses.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    List<Integer> getAllAddresses(Collection<Value> valuesFromSymbolTable, Map<Integer, Value> heap)
    {
        List<Integer> listOfAddresses = new LinkedList<>();
        valuesFromSymbolTable.stream()
                .filter(value -> value instanceof ReferenceValue)
                .forEach(value ->
                {
                    while (value instanceof ReferenceValue)
                    {
                        listOfAddresses.add(((ReferenceValue) value).getAddress());
                        value = heap.get(((ReferenceValue) value).getAddress());
                    }
                });
        return listOfAddresses;
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
            this.repository.logProgramStateExec(programState);
        while (!programState.getExecutionStack().isEmpty())
        {
            this.oneStep(programState);
            if (this.getShowAllSteps())
                this.repository.logProgramStateExec(programState);
            programState.getHeapTable().setContent(garbageCollector
            (
                    getAllAddresses(programState.getSymbolTable().getContent().values(), programState.getHeapTable().getContent()),
                    programState.getHeapTable().getContent()
            ));
        }
        if (!this.getShowAllSteps())
            this.repository.logProgramStateExec(programState);
    }

    public boolean getShowAllSteps() {return this.showAllSteps;}
    public void setShowAllSteps(boolean showAllSteps) {this.showAllSteps = showAllSteps;}

    /*
    Map<Integer, Value> unsafeGarbageCollector(List<Integer> symbolTableAddresses, Map<Integer, Value> heap)
    {
        return heap.entrySet().stream()
                .filter(e -> symbolTableAddresses.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    List<Integer> getAddressFromSymbolTable(Collection<Value> symbolTableValues)
    {
        return symbolTableValues.stream()
                .filter(v -> v instanceof ReferenceValue)
                .map(v -> {ReferenceValue v1 = (ReferenceValue) v; return v1.getAddress();})
                .collect(Collectors.toList());
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
            programState.getHeapTable().setContent(unsafeGarbageCollector(
                    getAddressFromSymbolTable(programState.getSymbolTable().getContent().values()),
                    programState.getHeapTable().getContent()
            ));
        }
        if (!this.getShowAllSteps())
            this.repository.logPrgStateExec(programState);
    }
    */
}
