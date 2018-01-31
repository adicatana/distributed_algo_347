defmodule Peer do

  def register_neighbours do
    receive do
      {:neighbours, peer_list} ->
        start(:neighbours, peer_list)
    end
  end

  def start(:neighbours, peer_list) do
    receive do
      {:root, peer_list} ->
        IO.puts "Root found..."
        
        Enum.map(peer_list, fn(n) ->
          send n, {:parent, self()}
        end)
        count(:no, 1)

      {:parent, parent} ->

        Enum.map(peer_list, fn(n) ->
          send n, {:parent, self()}
        end)
        count(:no, 1, :parent, parent)
    end
  end

  defp count(:no, current) do
    receive do
      {:hello, _} -> count(:no, current + 1)    
    after
      1_000 -> IO.puts "Peer #{inspect(self())} Parent does not exist for root Messages seen = #{current}..."
      count(:no, current)
    end    
  end

  defp count(:no, current, :parent, parent) do
    receive do
      {:hello, _} -> count(:no, current + 1, :parent, parent)    
    after
      1_000 -> IO.puts "Peer #{inspect(self())} Parent #{inspect(parent)} Messages seen = #{current}..."
      count(:no, current, :parent, parent)
    end
  end

end
