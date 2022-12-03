#! /usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(fn g ->
  [opponent, play] =
    g
    |> String.split(" ", trim: true)
    |> Enum.map(fn s -> to_charlist(s) |> Enum.at(0) end)

  opponent = opponent - ?A
  play = play - ?X
  1 + play + 3 * rem(4 + play - opponent, 3)
end)
|> Enum.sum()
|> IO.puts()
