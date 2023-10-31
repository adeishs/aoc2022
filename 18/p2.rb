#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

def get_air(airs, lavas, x, y, z)
  return if airs.member?([x, y, z]) || lavas.member?([x, y, z])

  airs.add([x, y, z])
  get_air(airs, lavas, x - 1, y, z)
  get_air(airs, lavas, x + 1, y, z)
  get_air(airs, lavas, x, y - 1, z)
  get_air(airs, lavas, x, y + 1, z)
  get_air(airs, lavas, x, y, z - 1)
  get_air(airs, lavas, x, y, z + 1)
end

def count_num_of_surfaces(airs, coord)
  x, y, z = coord

  [
    [x - 1, y, z], [x + 1, y, z],
    [x, y - 1, z], [x, y + 1, z],
    [x, y, z - 1], [x, y, z + 1]
  ].select { |cx, cy, cz| airs.member?([cx, cy, cz]) }.size
end

MAX = 20
lavas = Set[*$stdin.each_line
                   .map { |line| line.chomp.split(',').map(&:to_i) }]
airs = Set.new

(-1..MAX).each do |i|
  (-1..MAX).each do |j|
    [-1, MAX].each { |k| airs.merge([[k, i, j], [i, k, j], [i, j, k]]) }
  end
end

get_air(airs, lavas, 0, 0, 0)

puts lavas.map { |c| count_num_of_surfaces(airs, c) }.sum
