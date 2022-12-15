#!/usr/bin/env ruby
# frozen_string_literal: true

DISP = {
  'L' => -1 + 0i,
  'R' => 1 +  0i,
  'U' => 0 +  1i,
  'D' => 0 + -1i
}.freeze

NUM_OF_KNOTS = 10

# 0 is H, 1 is 1, …
pos = [0 + 0i] * NUM_OF_KNOTS

vs = [pos.last]
$stdin.each_line do |m|
  dir, d = m.split(' ')

  d.to_i.times do
    pos[0] += DISP[dir]

    (1...NUM_OF_KNOTS).each do |i|
      next unless (pos[i].real - pos[i - 1].real).abs > 1 ||
                  (pos[i].imag - pos[i - 1].imag).abs > 1

      pos[i] += Complex(pos[i - 1].real <=> pos[i].real,
                        pos[i - 1].imag <=> pos[i].imag)
    end
    vs.append(pos.last)
  end
end

puts vs.uniq.size
