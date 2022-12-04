#! /usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(fn a ->
  sections =
    a
    |> String.split(",", trim: true)
    |> Enum.map(fn r ->
      [s, e] =
        r
        |> String.split("-", trim: true)
        |> Enum.map(&String.to_integer/1)

      s..e
      |> Enum.to_list()
      |> MapSet.new()
    end)

  if MapSet.subset?(sections |> Enum.at(0), sections |> Enum.at(1)) ||
       MapSet.subset?(sections |> Enum.at(1), sections |> Enum.at(0)) do
    1
  else
    0
  end
end)
|> Enum.sum()
|> IO.puts()
