#!/usr/bin/env ruby
# frozen_string_literal: true

def parse(line)
  _, src, _, _, rate, _, _, _, _, dests = line.split(' ', 10)
  [
    src,
    {
      rate: rate.split(/[=;]/).pop.to_i,
      dests: dests.split(/,? /)
    }
  ]
end

valves = $stdin.each_line
               .map { |line| parse(line.chomp) }
               .to_h
puts valves.to_s
