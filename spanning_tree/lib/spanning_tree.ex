defmodule Flooding do
  def main do
    start()
  end

  def start do

    IO.puts "Creating the peers..."

    number_of_peers = 10

    peer_ids = Enum.map(1..number_of_peers, fn(_) -> 
      spawn(Peer, :register_neighbours, [])
    end)

    IO.puts "#{number_of_peers} peers created..."

    bind(peer_ids, 0, [1, 6])
    bind(peer_ids, 1, [0, 2, 3])
    bind(peer_ids, 2, [1, 3, 4])
    bind(peer_ids, 3, [1, 2, 5])
    bind(peer_ids, 4, [2])
    bind(peer_ids, 5, [3])
    bind(peer_ids, 6, [0, 7])
    bind(peer_ids, 7, [6, 8, 9])
    bind(peer_ids, 8, [7, 9])
    bind(peer_ids, 9, [7, 8])    

    Process.sleep(15000)

    IO.puts "Connection ended..."

  end

  def bind(peers, peer_id, neigbours_ids) do    
    peer = Enum.at(peers, peer_id)
    neigbours = Enum.map(neigbours_ids, fn(x) ->
      Enum.at(peers, x)
    end)

    send peer, {:neighbours, neigbours}

    if peer_id == 0 do
      send peer, {:root, neigbours}
    end
  end

end
