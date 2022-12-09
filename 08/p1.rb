#!/usr/bin/env ruby
# frozen_string_literal: true

heights = $stdin.read.split("\n").map { |row| row.split('').map(&:to_i) }

max_row = heights.size - 1
max_col = heights[0].size - 1

visibles =
  (1...max_row).to_a
               .product((1...max_col).to_a)
               .map do |row, col|
    curr = heights[row][col]

    v = heights[0][col] < curr &&
        (1...row).map { |i| heights[i][col] }
                 .select { |h| h >= curr }
                 .empty? ||
        heights[max_row][col] < curr &&
        (row + 1...max_row).map { |i| heights[i][col] }
                           .select { |h| h >= curr }
                           .empty? ||
        heights[row][0] < curr &&
        (1...col).map { |i| heights[row][i] }
                 .select { |h| h >= curr }
                 .empty? ||
        heights[row][max_col] < curr &&
        (col + 1...max_col).map { |i| heights[row][i] }
                           .select { |h| h >= curr }
                           .empty?

    v
  end

puts 2 * (max_row + max_col) +
     visibles.select { |v| v }.size
