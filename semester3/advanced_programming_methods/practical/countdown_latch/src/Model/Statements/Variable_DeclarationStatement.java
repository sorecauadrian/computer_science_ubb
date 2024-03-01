package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ADTs.MyList;
import Model.ADTs.MyList_Interface;
import Model.ADTs.MyStack_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.BoolType;
import Model.Types.IntType;
import Model.Types.StringType;
import Model.Types.Type;
import Model.Values.BoolValue;
import Model.Values.IntValue;
import Model.Values.StringValue;
import Model.Values.Value;

public class Variable_DeclarationStatement implements Statement
{
    private String name;
    private Type type;

    public Variable_DeclarationStatement(String name,Type type)
    {
        this.name=name;
        this.type=type;
    }

    @Override
    public ProgramState execute(ProgramState state) throws Exception
    {
        MyDictionary_Interface<String,Value> table=state.get_symbol_table();
        MyList_Interface<Value> output=state.get_output();
        MyStack_Interface<Statement> stack= state.get_execution_stack();

        if(table.is_defined(this.name))
        {
            throw new MyException("Variable already defined!");
        }
        else
        {
            table.update(this.name,this.type.default_value());
        }
        return null;


    }

    @Override
    public MyDictionary_Interface<String, Type> type_check(MyDictionary_Interface<String, Type> type_environment) throws Exception {
        type_environment.add(name,type);
        return type_environment;
    }

    public String toString()
    {
        return this.type.toString() + " "+this.name;
    }

}
