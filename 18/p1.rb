#!/usr/bin/env ruby
# frozen_string_literal: true

cube = {}
$stdin.each_line
      .map { |line| line.chomp.split(',').map(&:to_i) }
      .each { |x, y, z| cube[[x, y, z]] = true }

count = 0
cube.each do |k, _|
  x, y, z = k
  [-1, 1].each do |d|
    count += [
      [x + d, y, z],
      [x, y + d, z],
      [x, y, z + d]
    ].reject { |sx, sy, sz| cube[[sx, sy, sz]] }.size
  end
end

puts count
