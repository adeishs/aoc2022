#!/usr/bin/env elixir

IO.read(:stdio, :all)
|> String.split("\n", trim: true)
|> Enum.map(fn g ->
  [opponent, outcome] = g |> String.split(" ", trim: true)

  played_shape =
    case outcome do
      "X" ->
        case opponent do
          "A" -> "Z"
          "B" -> "X"
          "C" -> "Y"
        end

      "Y" ->
        case opponent do
          "A" -> "X"
          "B" -> "Y"
          "C" -> "Z"
        end

      "Z" ->
        case opponent do
          "A" -> "Y"
          "B" -> "Z"
          "C" -> "X"
        end

      _ ->
        0
    end

  case "#{opponent} #{played_shape}" do
    "A X" -> 1 + 3
    "A Y" -> 2 + 6
    "A Z" -> 3 + 0
    "B X" -> 1 + 0
    "B Y" -> 2 + 3
    "B Z" -> 3 + 6
    "C X" -> 1 + 6
    "C Y" -> 2 + 0
    "C Z" -> 3 + 3
    _ -> 0
  end
end)
|> Enum.sum()
|> IO.puts()
