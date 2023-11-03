#!/usr/bin/env ruby
# frozen_string_literal: true

heights = $stdin.read.split("\n").map { |row| row.split('').map(&:to_i) }

max_row = heights.size - 1
max_col = heights[0].size - 1

highest_scenic_score =
  [*1...max_row].product([*1...max_col]).map do |row, col|
    count = lambda do |line_heights|
      1 + (
        line_heights.find_index { |h| h >= heights[row][col] } ||
        line_heights.size
      )
    end

    count.call((col - 1).downto(1).map { |x| heights[row][x] }) *
      count.call((col + 1...max_col).map { |x| heights[row][x] }) *
      count.call((row - 1).downto(1).map { |y| heights[y][col] }) *
      count.call((row + 1...max_row).map { |y| heights[y][col] })
  end.max

puts highest_scenic_score
