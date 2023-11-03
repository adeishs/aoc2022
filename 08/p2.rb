#!/usr/bin/env ruby
# frozen_string_literal: true

heights = $stdin.read.split("\n").map { |row| row.split('').map(&:to_i) }

max_row = heights.size - 1
max_col = heights[0].size - 1

highest_scenic_score =
  (1...max_row).to_a.product((1...max_col).to_a).map do |row, col|
    visible_counts = []

    c = 1
    (col - 1).downto(1).each do |x|
      break if heights[row][x] >= heights[row][col]

      c += 1
    end
    visible_counts.push(c)

    c = 1
    (col + 1...max_col).each do |x|
      break if heights[row][x] >= heights[row][col]

      c += 1
    end
    visible_counts.push(c)

    c = 1
    (row - 1).downto(1).each do |y|
      break if heights[y][col] >= heights[row][col]

      c += 1
    end
    visible_counts.push(c)

    c = 1
    (row + 1...max_row).each do |y|
      break if heights[y][col] >= heights[row][col]

      c += 1
    end
    visible_counts.push(c)

    visible_counts.reduce(1, :*)
  end.max

puts highest_scenic_score
