#!/usr/bin/env ruby
# frozen_string_literal: true

buffer = $stdin.readline.chomp.split('')
SLICE_LEN = 4
i = 0

loop do
  break if buffer[0...SLICE_LEN].uniq.size == SLICE_LEN

  i += 1
  buffer.shift
end

puts (i + SLICE_LEN).to_s
