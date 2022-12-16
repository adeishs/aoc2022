#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

COUNT_ROW = 2_000_000

def get_coord(s, prefix)
  re, im = s.sub(prefix, '').sub(' y=', '').split(',').map(&:to_i)
  Complex(re, im)
end

def parse(line)
  sensor_str, beacon_str = line.split(': ')

  {
    S: get_coord(sensor_str, 'Sensor at x='),
    B: get_coord(beacon_str, 'closest beacon is at x=')
  }
end

def manhattan_dist(a, b)
  (a.real - b.real).abs + (a.imag - b.imag).abs
end

def get_coverages(sb, beacons)
  dist = manhattan_dist(sb[:S], sb[:B])
  min_x = sb[:S].real - dist
  max_x = sb[:S].real + dist
  min_y = sb[:S].imag - dist
  max_y = sb[:S].imag + dist

  return Set.new([]) unless COUNT_ROW.between?(min_y, max_y)

  Set.new(
    (min_x..max_x).map { |x| Complex(x, COUNT_ROW) }
                  .reject do |c|
                    manhattan_dist(sb[:S], c) > dist || beacons.include?(c)
                  end
  )
end

sbs = $stdin.each_line
            .map { |line| parse(line.chomp) }
beacons = Set.new(sbs.map { |sb| sb[:B] })
puts sbs.map { |sb| get_coverages(sb, beacons) }
        .reduce { |acc, c| acc.merge(c) }
        .size
