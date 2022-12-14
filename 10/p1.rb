#!/usr/bin/env ruby
# frozen_string_literal: true

x = 1
total = 0
cycle = 0
$stdin.each_line
      .map { |cmd| cmd.split(' ') }
      .map do |inst, op|
  num_of_cycles = 0
  if inst == 'noop'
    op = 0
    num_of_cycles = 1
  else
    op = op.to_i
    num_of_cycles = 2
  end

  num_of_cycles.times do
    cycle += 1
    total += cycle * x if [20, 60, 100, 140, 180, 220].include?(cycle)
  end
  x += op
end

puts total
