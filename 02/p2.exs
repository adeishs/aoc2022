#! /usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(fn g ->
  [opponent, outcome] =
    g
    |> String.split(" ", trim: true)
    |> Enum.map(fn s -> to_charlist(s) |> Enum.at(0) end)

  opponent = opponent - ?A
  play = rem(3 + opponent + outcome - ?X - 1, 3)

  1 + play +
    cond do
      play == opponent -> 3
      (play - opponent) in [1, -2] -> 6
      true -> 0
    end
end)
|> Enum.sum()
|> IO.puts()

# 10238
