#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

SCAN_MAX = 4_000_000

def get_coord(s, prefix)
  re, im = s.sub(prefix, '').sub(' y=', '').split(',').map(&:to_i)
  Complex(re, im)
end

def manhattan_dist(a, b)
  (a.real - b.real).abs + (a.imag - b.imag).abs
end

def parse(line)
  sensor_str, beacon_str = line.split(': ')

  sensor = {
    S: get_coord(sensor_str, 'Sensor at x='),
    B: get_coord(beacon_str, 'closest beacon is at x=')
  }
  sensor[:dist] = manhattan_dist(sensor[:S], sensor[:B])
  sensor
end

def find_distress(sbs)
  adjs = []
  (0..SCAN_MAX).each do |ty|
    exists = sbs.map { |sb| [sb[:S].real, sb[:dist] - (ty - sb[:S].imag).abs] }
                .select { |_sx, rem| rem >= 0 }
                .map { |sx, rem| { s: sx - rem, e: sx + rem } }
                .sort { |a, b| a[:s] <=> b[:s] || a[:e] <=> b[:e] }

    adjs = [exists.shift]
    until exists.size.zero?
      if adjs.last[:e] >= exists[0][:s]
        adjs[-1][:e] = exists[0][:e] if exists[0][:e] >= adjs.last[:e]
        exists.shift
      else
        adjs << exists.shift
      end
    end

    return Complex(adjs[0][:e] + 1, ty) if adjs.size == 2 &&
                                           adjs[0][:e].between?(0, SCAN_MAX)
  end
end

sbs = $stdin.each_line
            .map { |line| parse(line.chomp) }
distress = find_distress(sbs)
puts 4_000_000 * distress.real + distress.imag
