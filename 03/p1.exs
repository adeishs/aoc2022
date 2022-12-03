#! /usr/bin/env elixir

get_items = fn r, len, half ->
  MapSet.new(to_charlist(String.slice(r, half * len, len)))
end

IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(fn r ->
  len = div(String.length(r), 2)
  c = [0, 1] |> Enum.map(fn half -> get_items.(r, len, half) end)

  i =
    Enum.at(
      MapSet.intersection(Enum.at(c, 0), Enum.at(c, 1)) |> MapSet.to_list(),
      0
    )

  1 +
    cond do
      i >= ?a && i <= ?z -> i - ?a
      i >= ?A && i <= ?Z -> i - ?A + 26
      true -> 0
    end
end)
|> Enum.sum()
|> IO.puts()
