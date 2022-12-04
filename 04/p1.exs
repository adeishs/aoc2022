#! /usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(fn a ->
  [[s0l, s0u], [s1l, s1u]] =
    a
    |> String.split(",", trim: true)
    |> Enum.map(fn r ->
      r
      |> String.split("-", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)

  if (s0l <= s1l && s0u >= s1u) || (s1l <= s0l && s1u >= s0u) do
    1
  else
    0
  end
end)
|> Enum.sum()
|> IO.puts()
