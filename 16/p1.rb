#!/usr/bin/env ruby
# frozen_string_literal: true

def parse(line)
  els = line.split(' ')
  src = els.shift(2).pop
  rate = els.shift(3).pop.sub('rate=', '').sub(';', '').to_i
  els.shift(4)
  dests = els.map { |v| v.sub(',', '') }
  [
    src,
    {
      rate: rate,
      dests: dests
    }
  ]
end

valves = $stdin.each_line
               .map { |line| parse(line.chomp) }
               .to_h
puts valves.to_s
