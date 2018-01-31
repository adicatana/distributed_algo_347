defmodule Peer do

  def register_neighbours do
    receive do
      {:neighbours, peer_list} ->
        start(:neighbours, peer_list, :map, MapSet.new)
    end
  end

  def start(:neighbours, peer_list, :map, children) do
    receive do
      {:root, peer_list} ->
        IO.puts "Root found..."
        
        Enum.map(peer_list, fn(n) ->
          send n, {:parent, self()}
        end)
        count(:no, 1, :map, children)

      {:parent, parent} ->

        send parent, {:child, self()}

        Enum.map(peer_list, fn(n) ->
          send n, {:parent, self()}
        end)
        count(:no, 1, :parent, parent, :map, children)

      {:child, child} ->
        start(:neighbours, peer_list, :map, children)
    end
  end

  defp count(:no, current, :map, children) do
    receive do
      {:child, child} ->
        count(:no, current, :map, MapSet.put(children, child))
      {:hello, _} -> count(:no, current + 1, :map, children)    
    after
      1_000 -> IO.puts "Peer #{inspect(self())} Parent does not exist for root Children = #{inspect(children)}...\n"
      count(:no, current, :map, children)
    end    
  end

  defp count(:no, current, :parent, parent, :map, children) do
    receive do
      {:child, child} ->
        count(:no, current, :parent, parent, :map, MapSet.put(children, child))
      {:hello, _} -> count(:no, current + 1, :parent, parent, :map, children)    
    after
      1_000 -> 
        IO.puts "Peer #{inspect(self())} Parent #{inspect(parent)} Children = #{inspect(children)}..."
        count(:no, current, :parent, parent, :map, children)
    end
  end

end
