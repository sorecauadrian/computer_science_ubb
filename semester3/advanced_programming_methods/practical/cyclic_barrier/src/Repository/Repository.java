package Repository;

import Model.ProgramState.ProgramState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class Repository implements Repository_Interface
{

    private List<ProgramState> program_states_list;
    int index=0;
    private String file_path;
    private boolean first_access;

    public Repository()
    {
        this.program_states_list =new ArrayList<>();
        this.index=0;
        this.first_access =true;

    }

    public Repository(String file_path)
    {
        this.program_states_list =new ArrayList<>();
        this.index=0;
        this.file_path=file_path;
        this.first_access =true;
    }


    @Override
    public void add_program_state(ProgramState program_state)
    {
        this.program_states_list.add(program_state);

    }






    @Override
    public void log_program_state_execution(ProgramState program_state) throws IOException
    {
        PrintWriter writer;

        if(first_access)
        {
            writer=new PrintWriter(new BufferedWriter(new FileWriter(this.file_path,false)));
            this.first_access=false;
        }
        else
        {
            writer=new PrintWriter(new BufferedWriter(new FileWriter(this.file_path,true)));
        }
        writer.print(program_state);
        writer.close();
    }

    @Override
    public List<ProgramState> get_program_states_list()
    {
        return program_states_list;
    }

    @Override
    public void set_program_states_list(List<ProgramState> program_states_list)
    {
        this.program_states_list =program_states_list;

    }

    @Override
    public ProgramState get_program_by_id(int id) {

        for(ProgramState program_state:program_states_list)
        {
            if(program_state.get_id()==id)
            {
                return program_state;
            }
        }

        return null;
    }
}
