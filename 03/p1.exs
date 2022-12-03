#! /usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(fn r ->
  len = div(String.length(r), 2)

  c1 = MapSet.new(to_charlist(String.slice(r, 0..(len - 1))))
  c2 = MapSet.new(to_charlist(String.slice(r, len..-1)))
  i = Enum.at(MapSet.intersection(c1, c2) |> MapSet.to_list(), 0)

  1 +
    cond do
      i >= ?a && i <= ?z -> i - ?a
      i >= ?A && i <= ?Z -> i - ?A + 26
      true -> 0
    end
end)
|> Enum.sum()
|> IO.puts()
