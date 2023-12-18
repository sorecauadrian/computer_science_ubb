package controller;

import exceptions.InterpreterException;
import model.ProgramState;
import model.values.ReferenceValue;
import model.values.Value;
import repository.RepositoryInterface;

import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Controller
{
    private final RepositoryInterface repository;
    private boolean showAllSteps;
    ExecutorService executor;
    public Controller(RepositoryInterface repo)
    {
        this.repository = repo;
        this.showAllSteps = false;
    }

    private Map<Integer, Value> garbageCollector(List<Integer> symbolTableAddresses, Map<Integer, Value> heap)
    {
        return heap.entrySet().stream()
                .filter(e -> symbolTableAddresses.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    private List<Integer> getAdressesFromSymbolTable(Collection<Value> symbolTableValue, Collection<Value> heap)
    {
        return Stream.concat
        (
                heap.stream()
                        .filter(v -> v instanceof ReferenceValue)
                        .map(v -> {ReferenceValue v1 = (ReferenceValue) v; return v1.getAddress();}),
                symbolTableValue.stream()
                        .filter(v -> v instanceof ReferenceValue)
                        .map(v -> {ReferenceValue v1 = (ReferenceValue) v; return v1.getAddress();})
        ).collect(Collectors.toList());
    }

    public void conservativeGarbageCollector(List<ProgramState> programStateList)
    {
        var heap = Objects.requireNonNull(programStateList.stream()
                .map(p -> getAdressesFromSymbolTable
                        (
                                p.getSymbolTable().getContent().values(),
                                p.getHeapTable().getContent().values()
                        ))
                .map(Collection::stream)
                .reduce(Stream::concat).orElse(null)).collect(Collectors.toList());

        programStateList.forEach(programState ->
                programState.getHeapTable().setContent
                        (
                        garbageCollector(heap,
                                        programStateList.getFirst().getHeapTable().getContent()
                        )));
    }

    public void allStep() throws InterpreterException
    {
        this.executor = Executors.newFixedThreadPool(2);
        List<ProgramState> programStateList = removeCompletedPrograms(this.repository.getProgramList());
        if (this.getShowAllSteps())
            programStateList.forEach(prg ->
            {
                try {this.repository.logProgramStateExec(prg);}
                catch (InterpreterException exception) {exception.printStackTrace();}
            });
        while (!programStateList.isEmpty())
        {
            conservativeGarbageCollector(programStateList);
            oneStepForAllPrograms(programStateList);
            programStateList = removeCompletedPrograms(this.repository.getProgramList());
        }
        this.executor.shutdownNow();
        this.repository.setProgramList(programStateList);
        if (!this.getShowAllSteps())
            programStateList.forEach(prg ->
            {
                try {this.repository.logProgramStateExec(prg);}
                catch (InterpreterException exception) {exception.printStackTrace();}
            });
    }

    public void oneStepForAllPrograms(List<ProgramState> programStateList) throws InterpreterException
    {
        List<Callable<ProgramState>> callList = programStateList.stream()
                .map((ProgramState p) -> (Callable<ProgramState>) (p::oneStep))
                .collect(Collectors.toList());
        try
        {
            List<ProgramState> newProgramList = this.executor.invokeAll(callList).stream()
                    .map(future ->
                    {
                        try {return future.get();}
                        catch (InterruptedException | ExecutionException e) {System.out.println(e.getMessage());}
                        return null;
                    })
                    .filter(Objects::nonNull)
                    .toList();
            programStateList.addAll(newProgramList);
        }
        catch (InterruptedException e) {throw new InterpreterException(e.getMessage());}

        if (this.getShowAllSteps())
            programStateList.forEach(prg ->
            {
                try {this.repository.logProgramStateExec(prg);}
                catch (InterpreterException exception) {exception.printStackTrace();}
            });
        this.repository.setProgramList(programStateList);
    }

    List<ProgramState> removeCompletedPrograms(List<ProgramState> inProgramList)
    {
        return inProgramList.stream()
                .filter(ProgramState::isNotCompleted)
                .collect(Collectors.toList());
    }

    public boolean getShowAllSteps() {return this.showAllSteps;}
    public void setShowAllSteps(boolean showAllSteps) {this.showAllSteps = showAllSteps;}

}
