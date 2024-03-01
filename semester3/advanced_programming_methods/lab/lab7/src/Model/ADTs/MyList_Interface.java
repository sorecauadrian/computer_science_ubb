package Model.ADTs;

import java.util.List;

public interface MyList_Interface<T>
{
    void add(T element);
    void remove(T element) throws Exception;
    T get_element(int index) throws Exception;
    int size();
    List get_content();

    @Override
    String  toString();


}
