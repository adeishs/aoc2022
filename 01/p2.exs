#!/usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n\n", trim: true)
|> Enum.map(fn s ->
  s
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum()
end)
|> Enum.sort(:desc)
|> Enum.take(3)
|> Enum.sum()
|> IO.puts()
