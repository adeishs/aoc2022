#!/usr/bin/env ruby
# frozen_string_literal: true

heights = $stdin.read.split("\n").map { |row| row.split('').map(&:to_i) }

max_row = heights.size - 1
max_col = heights[0].size - 1

scenic_scores = (1...max_row).to_a
                             .product((1...max_col).to_a)
                             .map do |row, col|
  [
    (row - 1..0).step(-1)
                .map { |i| [heights[i][col], heights[i + 1][col]] }
                .index { |curr, prev| curr >= prev } || (row - 1),
    (row + 1..max_row).map { |i| [heights[i][col], heights[i - 1][col]] }
                      .index { |curr, prev| curr >= prev } || (max_row - row),
    (col - 1..0).step(-1)
                .map { |i| [heights[row][i], heights[row][i + 1]] }
                .index { |curr, prev| curr >= prev } || (col - 1),
    (col + 1..max_col).map { |i| [heights[row][i], heights[row][i - 1]] }
                      .index { |curr, prev| curr >= prev } || (max_col - col)
  ].reduce { |acc, d| acc * (d + 1) }
end

puts scenic_scores.max
