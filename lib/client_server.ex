defmodule ClientServer do

def main do 

  IO.puts "Starting connection..."

  server = spawn(Server, :start, [])
  
  IO.puts "Server process created...\n"

  Enum.map(1..5, fn(x) -> 
  	client = spawn(Client, :start_client, [])

  	IO.puts "Client #{inspect(x)} process created with PID: #{inspect(client)}..."

	send client, { :bind, server }
	send server, { :start }  
  end)

  IO.puts ""
  
  Process.sleep(15000)

  IO.puts "Ending connection..."

end

end # module -----------------------


