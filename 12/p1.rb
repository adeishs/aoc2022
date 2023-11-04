#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

# + 2 to make it not climbable
WALL_HEIGHT = 'z'.ord + 2

inps = $stdin.each_line.map { |l| l.chomp.split('') }

heights = Hash.new(WALL_HEIGHT)
start_point = -1 + -1i
end_point = -1 + -1i
inps.each_with_index do |cols, y|
  cols.each_with_index do |height_letter, x|
    point = Complex(x, y)
    if height_letter == 'S'
      height_letter = 'a'
      start_point = point
    elsif height_letter == 'E'
      height_letter = 'z'
      end_point = point
    end

    heights[point] = height_letter.ord - 'a'.ord
  end
end

visited = Set[]
time = 0
queue = [
  {
    time: time,
    point: start_point
  }
]

loop do
  break if queue.empty?

  curr = queue.shift

  time = curr[:time]
  break if curr[:point] == end_point
  next if visited.include?(curr[:point])

  visited.add(curr[:point])

  queue.concat(
    [
      0 + 1i, 0 + -1i, 1 + 0i, -1 + 0i
    ].map { |d| curr[:point] + d }
      .select { |adj| (heights[adj] || -1) <= heights[curr[:point]] + 1 }
      .map { |adj| { time: time + 1, point: adj } }
  )
end

puts time
