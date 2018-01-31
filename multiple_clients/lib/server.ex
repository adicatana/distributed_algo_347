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

    { :triangle, :a, l1, :b, l2, :c, l3, :pid, id } ->
      IO.puts ["Received from ", inspect(id)]  
      sp = (l1 + l2 + l3) / 2
      
      area = :math.sqrt((sp - l1) * (sp - l2) * (sp - l3) * sp)

      send id, { :result, area, :type, "triangle" }      

    end
    
    next()
  end # next

end # module -----------------------

