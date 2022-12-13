#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

def compare_pair(a, b)
  i = 0
  loop do
    return true if a[i].nil?
    return false if b[i].nil?

    if !a[i].kind_of?(Array) && !b[i].kind_of?(Array) then
      return true if a[i] < b[i]
      return false if a[i] > b[i]
    else
      a[i] = [a[i]] unless a[i].kind_of?(Array)
      b[i] = [b[i]] unless b[i].kind_of?(Array)

      return compare_pair(a[i], b[i])
    end

    i += 1
  end
end

puts $stdin.read
      .split("\n\n")
  .map { |pair_str| pair_str.split("\n").map { |v| JSON.parse(v) } }
  .map { |a, b| compare_pair(a, b) }
  .map.with_index { |correct, i| if correct then i + 1 else 0 end }
  .reduce(&:+)
