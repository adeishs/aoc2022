#!/usr/bin/env ruby
# frozen_string_literal: true

layout, insts = $stdin.read.split("\n\n")

stacks = layout.split("\n")
               .reverse
               .drop(1)
               .map { |l| (0..9).map { |i| l[4 * i + 1] } }
               .transpose
               .map { |s| s.reject { |b| b.nil? || b == ' ' } }
               .reject(&:empty?)

insts.split("\n")
     .map do |inst|
       _, n, _, src, _, dest = inst.split

       src = src.to_i - 1
       dest = dest.to_i - 1
       n = n.to_i
       move = stacks[src].pop(n)
       stacks[dest] = stacks[dest] + move
     end

puts stacks.map(&:pop).join
