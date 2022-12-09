#!/usr/bin/env ruby
# frozen_string_literal: true

DISP = {
  'L' => -1 + 0i,
  'R' => 1 +  0i,
  'U' => 0 +  1i,
  'D' => 0 + -1i
}.freeze

# 0 is H
pos = [0 + 0i] * 10

vs = [pos.last]
$stdin.each_line do |m|
  dir, d = m.split(' ')

  (0...d.to_i).each do |_|
    pos[0] += DISP[dir]

    next_mvt = false
    (0...9).each do |i|
      next_mvt ||= (pos[i].real - pos[i + 1].real).abs > 1 ||
                   (pos[i].imag - pos[i + 1].imag).abs > 1
      next if next_mvt

      pos[i + 1] = pos[i] - DISP[dir]
    end
    vs.append(pos.last)
  end

  puts vs.to_s
end

puts vs.uniq.size
