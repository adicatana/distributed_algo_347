defmodule Server do
 
  def start do

    IO.puts "Server starting..."

    receive do
      { :start } -> next() 
    end
  
  end # start
   
  def next() do
    receive do
    { :circle, radius, :pid, id } -> 
      IO.puts ["Received from ", inspect(id)]  
      send id, { :result, 3.14159 * radius * radius, :type, "circle" }

    { :square, side, :pid, id } -> 
      IO.puts ["Received from ", inspect(id)]  
      send id, { :result, side * side, :type, "square" }
    end
    
    next()
  end # next

end # module -----------------------

