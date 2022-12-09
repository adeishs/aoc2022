#!/usr/bin/env ruby
# frozen_string_literal: true

DISP = {
  'L' => -1 + 0i,
  'R' => 1 +  0i,
  'U' => 0 +  1i,
  'D' => 0 + -1i
}.freeze

pos = {
  H: 0 + 0i,
  T: 0 + 0i
}

vs = [pos[:T]]
$stdin.each_line do |m|
  dir, d = m.split(' ')

  (0...d.to_i).each do |_|
    pos[:H] += DISP[dir]

    next unless (pos[:H].real - pos[:T].real).abs > 1 ||
                (pos[:H].imag - pos[:T].imag).abs > 1

    pos[:T] = pos[:H] - DISP[dir]
    vs.append(pos[:T])
  end
end

puts vs.uniq.size
