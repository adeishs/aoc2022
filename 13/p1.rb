#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

def compare_pair(a, b)
  return 0 if a.empty? && b.empty?

  i = 0
  loop do
    return -1 if a[i].nil?
    return 1 if b[i].nil?

    if !a[i].kind_of?(Array) && !b[i].kind_of?(Array) then
      cmp = a[i] <=> b[i]
    else
      a[i] = [a[i]] unless a[i].kind_of?(Array)
      b[i] = [b[i]] unless b[i].kind_of?(Array)

      cmp = compare_pair(a[i], b[i])
    end

    return cmp unless cmp.zero?
    i += 1
  end
end

puts $stdin.read
           .split("\n\n")
           .map { |pair_str| pair_str.split("\n").map { |v| JSON.parse(v) } }
           .map { |a, b| compare_pair(a, b) }
           .map.with_index { |cmp, i| if cmp == -1 then i + 1 else 0 end }
           .reduce(&:+)
