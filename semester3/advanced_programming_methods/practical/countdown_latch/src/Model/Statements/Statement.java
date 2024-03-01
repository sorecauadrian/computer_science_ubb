package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyDictionary_Interface;
import Model.ProgramState.ProgramState;
import Model.Types.Type;

import java.io.FileNotFoundException;
import java.io.IOException;

public interface Statement
{
    ProgramState execute(ProgramState state) throws Exception;
    MyDictionary_Interface<String,Type> type_check(MyDictionary_Interface<String,Type> type_environment) throws Exception;
}
