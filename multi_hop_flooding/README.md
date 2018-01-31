# MultiHopFlooding

Flooding is a simple algorithm to send (broadcast) a message to all nodes on a multi-hop network, like a sensor network. More usefully, it can be used to build a rooted spanning tree.
This is the implementation for a multi-hop network.	

![Alt text](/network.png?raw=true "The network topology")

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `multi_hop_flooding` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:multi_hop_flooding, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/multi_hop_flooding](https://hexdocs.pm/multi_hop_flooding).

