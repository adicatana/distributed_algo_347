defmodule Peer do
  def start do
    receive do
      {:hello, peer_list} ->
        IO.puts "Peer #{inspect(self())} received first hello message..."
        IO.puts "Peer #{inspect(self())} flooding hello message...\n"

        Enum.map(peer_list, fn(n) ->
          send n, {:hello, peer_list}
        end)
        count(:no, 1)
    end
  end

  defp count(:no, current) do
    receive do
      {:hello, _} -> count(:no, current + 1)    
    after
      1_000 -> IO.puts "Peer #{inspect(self())} Messages seen = #{current}..."
      count(:no, current)
    end
  end

end
