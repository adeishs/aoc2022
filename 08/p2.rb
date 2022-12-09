#!/usr/bin/env ruby
# frozen_string_literal: true

heights = $stdin.read.split("\n").map { |row| row.split('').map(&:to_i) }

max_row = heights.size - 1
max_col = heights[0].size - 1

scenic_scores = (1...max_row).to_a
                             .product((1...max_col).to_a)
                             .map do |row, col|
  ds = []
  c = 0
  (row - 1...0).step(-1).each do |i|
    c += 1
    break if heights[i][col] >= heights[i + 1][col]
  end
  ds.append(c)

  c = 0
  (row + 1...max_row).each do |i|
    c += 1
    break if heights[i][col] >= heights[i - 1][col]
  end
  ds.append(c)

  c = 0
  (col - 1...0).step(-1).each do |i|
    c += 1
    break if heights[row][i] >= heights[row][i + 1]
  end
  ds.append(c)

  c = 0
  (col + 1...max_col).each do |i|
    c += 1
    break if heights[row][i] >= heights[row][i - 1]
  end
  ds.append(c)

  ds.reduce { |acc, d| acc * d }
end

puts scenic_scores.max
