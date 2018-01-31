
# distributed algorithms, n.dulay, 4 jan 18
# simple client-server, v1

defmodule Server do
 
def start do 
  IO.puts ["      Server at ", DNS.my_ip_addr()]
  receive do
  { :bind, client } -> next(client) 
  end
end # start
 
def next(client) do
  receive do
  { :circle, radius, :pid, id } -> 
    send client, { :result, 3.14159 * radius * radius, :type, "circle" }
    IO.puts "Process id of the client #{id}"

  { :square, side, :pid, id } -> 
    send client, { :result, side * side, :type, "square" }
    IO.puts "Process id of the client #{id}"

  end
  next(client)
end # next

end # module -----------------------

