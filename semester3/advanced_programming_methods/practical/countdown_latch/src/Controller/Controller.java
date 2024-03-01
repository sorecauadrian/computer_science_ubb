package Controller;

import Model.ProgramState.ProgramState;
import Repository.Repository_Interface;

import java.io.IOException;
import Model.Values.ReferenceValue;
import Model.Values.Value;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;
import java.util.stream.Stream;
public class Controller
{


    private Repository_Interface repository;
    private ExecutorService executor;



    public Controller(Repository_Interface repository)
    {
        this.repository=repository;
    }


    public void add_program_state(ProgramState program_state)
    {
        this.repository.add_program_state(program_state);
    }

    public Repository_Interface get_repository()
    {
        return repository;
    }

    public void set_repository(Repository_Interface repository)
    {
        this.repository = repository;
    }

    public void one_step_for_all_program_states(List<ProgramState> program_states_list) throws InterruptedException {
        //before the execution, print the PrgState List into the log file
        program_states_list.forEach(p->{
            try
            {
                repository.log_program_state_execution(p);
            }
            catch (IOException ignored)
            {

            }
        });

        //RUN concurrently one step for each of the existing PrgStates
        //-----------------------------------------------------------------------
        //prepare the list of callables

        List<Callable<ProgramState>> callables_list=program_states_list.stream()
                .map((ProgramState p) -> (Callable<ProgramState>)(p::execute_one_step))
                .collect(Collectors.toList());

        //start the execution of the callables
        //it returns the list of new created PrgStates (namely threads)

        List<ProgramState> new_program_states_list=executor.invokeAll(callables_list).stream()
                .map(future->
                {
                    try
                    {
                        return  future.get();
                    }
                    catch (InterruptedException | ExecutionException e)
                    {
                        //System.out.println(e.getMessage());
                        return  null;
                    }
                })
                .filter(e->e!=null)
                .collect(Collectors.toList());

        //add the new created threads to the list of existing threads
        program_states_list.addAll(new_program_states_list);

        //log every program state
        program_states_list.forEach(p->{
            try
            {
                repository.log_program_state_execution(p);

            }
            catch (IOException e)
            {
                e.printStackTrace();
            }

        });

      repository.set_program_states_list(program_states_list);

    }


    public void execute_one_step_for_all_programs() throws InterruptedException //new function for GUI Assignment
    {
        executor=Executors.newFixedThreadPool(2);
        repository.set_program_states_list(remove_completed_programs(repository.get_program_states_list()));
        List<ProgramState> program_states=repository.get_program_states_list();

        if(program_states.size() > 0)
        {
            try
            {
                one_step_for_all_program_states(repository.get_program_states_list());
            }
            catch (InterruptedException error)
            {
                System.out.println(error.getMessage());
            }
            repository.set_program_states_list(remove_completed_programs(repository.get_program_states_list()));
            executor.shutdown();
            call_garbage_collector(program_states);
        }

    }

    public void execute_all_steps() throws Exception,IOException
    {
        executor= Executors.newFixedThreadPool(2);
        List<ProgramState> program_states_list=remove_completed_programs(repository.get_program_states_list());

        while (program_states_list.size()>0)
        {
            // call GarbageCollector

            call_garbage_collector(program_states_list);
            one_step_for_all_program_states(program_states_list);
            program_states_list=remove_completed_programs(repository.get_program_states_list());

        }

        executor.shutdownNow();
        //HERE the repository still contains at least one Completed Prg
        program_states_list=remove_completed_programs(repository.get_program_states_list());
        repository.set_program_states_list(program_states_list);
    }



    public void call_garbage_collector(List<ProgramState> program_states_list)
    {
        program_states_list.forEach(
                p-> {p.get_heap().set_content(garbage_collector(get_addresses_from_symbol_table(p.get_symbol_table().get_content().values(),p.get_heap().get_content().values()),p.get_heap().get_content()));}
        );
    }

    Map<Integer,Value> garbage_collector(List<Integer> addresses_from_symbol_table, Map<Integer,Value> heap) //no longer unsafe
    {
        return heap.entrySet().stream().filter(e->addresses_from_symbol_table.contains(e.getKey())).collect(Collectors.toMap(Map.Entry::getKey,Map.Entry::getValue));
    }


    //take values from both heap table and symbol table, concatenate them
    List<Integer> get_addresses_from_symbol_table(Collection<Value> symbol_table_values,Collection<Value> heap)
    {
        return Stream.concat(heap.stream().filter(v -> v instanceof ReferenceValue).map(v -> {ReferenceValue v1=(ReferenceValue)v; return v1.get_address();}),
                symbol_table_values.stream().filter(v -> v instanceof ReferenceValue).map(v -> {ReferenceValue v1 = (ReferenceValue)v; return v1.get_address();})
                ).collect(Collectors.toList());

      //  return symbol_table_values.stream().filter(v->v instanceof ReferenceValue).map(v->{ReferenceValue v1=(ReferenceValue)v;return v1.get_address();}).collect(Collectors.toList());
    }

    public List<ProgramState> remove_completed_programs(List<ProgramState> program_states_in_progress_list)
    {
        return program_states_in_progress_list.stream()
                .filter(ProgramState::is_not_completed)
                .collect(Collectors.toList());
    }


}
