
# distributed algorithms, n.dulay, 9 jan 18
# simple client-server, v1

defmodule Client do

def start do
  IO.puts ["      Client at ", DNS.my_ip_addr()]
  receive do
  { :bind, server } -> next(server)
  end
end

defp next(server) do
  
  random = :rand.uniform(2)

  if random == 1 do

    send server, { :circle, 1.0, :pid, inspect self() }

  else  

    send server, { :square, 1.0, :pid, inspect self() }

  end

    receive do
    { :result, area, :type, shape } -> 
      IO.puts "Area of the #{shape} is #{area}" 
    end

  random = :rand.uniform(2)

  time = 2 * (random - 1) + 1

  Process.sleep(time * 1000)
  next(server)
end

end # module -----------------------

