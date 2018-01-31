defmodule Client do

def start_client do
  receive do
  { :bind, server } -> next(server)
  end
end

defp next(server) do
  
  random = :rand.uniform(3)

  cond do
    random == 1 ->
      IO.puts "Client #{inspect(self())} sending circle to the server..."
      send server, { :circle, 1.0, :pid, self() }
    random == 2 ->  
      IO.puts "Client #{inspect(self())} sending square to the server..."
      send server, { :square, 1.0, :pid, self() }
    random == 3 ->
      IO.puts "Client #{inspect(self())} sending triangle to the server..."
      send server, { :triangle, :a, 3, :b, 4, :c, 5, :pid, self() }      
  end

  IO.puts "Client #{inspect(self())} waiting..."  

  receive do
    { :result, area, :type, shape } -> 
      IO.puts "Area of the #{shape} is #{area}" 
  end

  random = :rand.uniform(2)

  time = 2 * (random - 1) + 1

  Process.sleep(time * 1000)
  next(server)
end

end
