defmodule Flooding do
  def main do
    start()
  end

  defp start do

    IO.puts "Creating the peers..."

    number_of_peers = 10

    peer_list = Enum.map(1..number_of_peers, fn(_) -> 
      spawn(Peer, :start, [])
    end)

    IO.puts "#{number_of_peers} peers created..."

    send Enum.at(peer_list, 0), {:hello, peer_list}

    Process.sleep(15000)

    IO.puts "Connection ended..."

  end

end
