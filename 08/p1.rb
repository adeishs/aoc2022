#!/usr/bin/env ruby
# frozen_string_literal: true

trees = $stdin.read.split("\n").map { |row| row.split('').map(&:to_i) }

n = (1...trees.size - 1).to_a.product((1...trees[0].size - 1).to_a).map do |row, col|
  (0..row).to_a.all? { |dr| trees[dr][col] < trees[row][col] } ||
    (row + 1...trees.size - 1).to_a.all? { |dr| trees[dr][col] < trees[row][col] } ||
    (0..col).to_a.all? { |dc| trees[row][dc] < trees[row][col] } ||
    (col + 1...trees[0].size - 1).to_a.all? { |dc| trees[row][dc] < trees[row][col] }
end.select { |v| v == true }.count + 2 * (trees.size + trees[0].size - 2)

puts n
