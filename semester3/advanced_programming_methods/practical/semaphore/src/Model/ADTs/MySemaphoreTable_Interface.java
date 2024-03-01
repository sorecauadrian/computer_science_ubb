package Model.ADTs;



import java.util.Map;

public interface MySemaphoreTable_Interface<V>
{

   Map<Integer, V> get_semaphore_table();
   void set_semaphore_table(Map<Integer,V> semaphore_table);
   void put(int address,V value);
   int get_address();
   boolean is_defined(int address);
   V lookup(int address);


}
