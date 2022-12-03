#! /usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(fn r ->
  len = div(String.length(r), 2)

  i =
    [0, len]
    |> Enum.map(fn ofs ->
      to_charlist(r |> String.slice(ofs, len))
      |> MapSet.new()
    end)
    |> Enum.reduce(fn c, acc -> MapSet.intersection(acc, c) end)
    |> MapSet.to_list()
    |> Enum.at(0)

  1 +
    cond do
      i >= ?a && i <= ?z -> i - ?a
      i >= ?A && i <= ?Z -> i - ?A + 26
      true -> 0
    end
end)
|> Enum.sum()
|> IO.puts()
