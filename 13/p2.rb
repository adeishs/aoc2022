#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

DISTRESS_SIGNALS = ['[[2]]', '[[6]]']

def compare_pair(a, b)
  return 0 if a.empty? && b.empty?

  i = 0
  loop do
    return 0 if a[i].nil? && b[i].nil?
    return -1 if a[i].nil?
    return 1 if b[i].nil?

    if !a[i].kind_of?(Array) && !b[i].kind_of?(Array) then
      cmp = a[i] <=> b[i]
    elsif a[i].kind_of?(Array) && !b[i].kind_of?(Array) then
      cmp = compare_pair(a[i], [b[i]])
    elsif !a[i].kind_of?(Array) && b[i].kind_of?(Array) then
      cmp = compare_pair([a[i]], b[i])
    else
      cmp = compare_pair(a[i], b[i])
    end

    return cmp unless cmp.zero?
    i += 1
  end
end

def distress(signal, i)
  return i + 1 if DISTRESS_SIGNALS.include?(signal)
  return 1
end

puts (
  DISTRESS_SIGNALS +
  $stdin.read
        .split("\n")
        .reject { |l| l.empty? }
).sort { |a, b| compare_pair(JSON.parse(a), JSON.parse(b)) }
 .map.with_index { |signal, i| distress(signal, i) }
 .reduce(&:*)
