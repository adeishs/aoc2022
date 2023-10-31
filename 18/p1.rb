#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

cube = Set[*$stdin.each_line
                  .map { |line| line.chomp.split(',').map(&:to_i) }]

puts cube.map(&:flatten).map { |x, y, z|
  [-1, 1].map do |d|
    [[x + d, y, z],
     [x, y + d, z],
     [x, y, z + d]].reject { |c| cube.member?(c) }.size
  end.sum
}.sum
