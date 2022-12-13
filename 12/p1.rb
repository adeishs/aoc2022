#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

inps = $stdin.each_line.map { |l| l.chomp.split('') }

heights = {}
start_point = -1 + -1i
end_point = -1 + -1i
inps.map.with_index do |cols, y|
  cols.map.with_index do |height_letter, x|
    point = x + y * (0 + 1i)
    if height_letter == 'S' then
      height_letter = 'a'
      start_point = point
    elsif height_letter == 'E' then
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

  queue.append(
    [
      0 + 1i, 0 + -1i, 1 + 0i, -1 + 0i
    ].map { |d| curr[:point] + d }
      .select { |adj| (heights[adj] || -1) >= heights[curr[:point]] }
      .map { |adj| { time: time + 1, point: adj } }
  )
end

puts time
