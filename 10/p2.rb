#!/usr/bin/env ruby
# frozen_string_literal: true

WIDTH = 40
HEIGHT = 6

def cycle_row(cycle)
  (cycle - 1).div(WIDTH)
end

pixels = [''] * HEIGHT

x = 1
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
    pixels[cycle_row(cycle)] += if ((cycle - 1) % WIDTH).between?(
                                    x - 1, x + 1
                                   ) then
                                  '#'
                                else
                                  '.'
                                end
  end
  x += op
end

puts pixels.join("\n")
