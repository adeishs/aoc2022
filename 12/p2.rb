#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

class Height
  attr_accessor :time, :point

  def initialize(time, point)
    @time = time
    @point = point
  end
end

def get_next_ones_in_queue(heights, curr)
  [
    0 + 1i, 0 + -1i, 1 + 0i, -1 + 0i
  ].map { |d| curr.point + d }
    .select { |adj| (heights[adj] || -1) <= heights[curr.point] + 1 }
    .map { |adj| Height.new(curr.time + 1, adj) }
end

def get_shortest(heights, start_point, end_point)
  visited = Set[]
  queue = [Height.new(0, start_point)]

  until queue.empty?
    curr = queue.shift
    return curr.time if curr.point == end_point

    next if visited.include?(curr.point)

    visited.add(curr.point)

    queue.concat(get_next_ones_in_queue(heights, curr))
    return curr.time if queue.empty? && (visited.size > 1)
  end

  nil
end

# + 2 to make it not climbable
WALL_HEIGHT = 'z'.ord + 2

inps = $stdin.each_line.map { |l| l.chomp.split('') }

heights = Hash.new(WALL_HEIGHT)
start_points = []
end_point = -1 + -1i
inps.each_with_index do |cols, y|
  cols.each_with_index do |height_letter, x|
    point = Complex(x, y)
    if height_letter == 'S'
      height_letter = 'a'
    elsif height_letter == 'E'
      height_letter = 'z'
      end_point = point
    end

    heights[point] = height_letter.ord - 'a'.ord
    start_points.push(point) if (heights[point]).zero?
  end
end

puts start_points.map { |sp| get_shortest(heights, sp, end_point) }
                 .reject(&:nil?)
                 .min
