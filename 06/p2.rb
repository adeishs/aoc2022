#!/usr/bin/env ruby
# frozen_string_literal: true

buffer = $stdin.readline.chomp.split('')
SLICE_LEN = 14
i = SLICE_LEN

loop do
  break if buffer[0...SLICE_LEN].uniq.size == SLICE_LEN

  i += 1
  buffer.shift
end

puts i
