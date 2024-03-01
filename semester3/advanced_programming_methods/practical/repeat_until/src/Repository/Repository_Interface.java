package Repository;

import Model.ProgramState.ProgramState;

import java.io.IOException;
import java.util.List;

public interface Repository_Interface
{
    public void add_program_state(ProgramState program_state);
    public void log_program_state_execution(ProgramState program_state) throws IOException;
    List<ProgramState> get_program_states_list();
    void set_program_states_list(List<ProgramState>program_states_list);
    ProgramState get_program_by_id(int id);
}
