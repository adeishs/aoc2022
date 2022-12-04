#! /usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.count(fn a ->
  [s0l, s0u, s1l, s1u] =
    Regex.split(~r{[,-]}, a)
    |> Enum.map(&String.to_integer/1)

  (s0l <= s1l && s0u >= s1u) || (s1l <= s0l && s1u >= s0u)
end)
|> IO.puts()
