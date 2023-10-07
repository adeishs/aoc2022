#!/usr/bin/env ruby
# frozen_string_literal: true

cube = Hash[*$stdin.each_line
                   .map { |line| line.chomp.split(',').map(&:to_i) }
                   .flat_map { |k| [k, true] }]

count = 0
cube.map(&:flatten).each do |x, y, z, _|
  [-1, 1].each do |d|
    count += [
      [x + d, y, z],
      [x, y + d, z],
      [x, y, z + d]
    ].reject { |c| cube[c] }.size
  end
end

puts count
