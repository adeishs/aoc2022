#!/usr/bin/env ruby
# frozen_string_literal: true

subdirs = [0]
sums = []
$stdin.each_line do |cmd|
  next if cmd == '$ cd /'

  toks = cmd.split
  next if toks[1] == 'ls' || toks[0] == 'dir'

  if toks[0] != '$'
    subdirs.append(subdirs.pop + toks[0].to_i)
  elsif toks[1] == 'cd'
    parent = toks.pop == '..'

    if parent
      sums.append(subdirs.pop)
      subdirs.append(subdirs.pop + sums[sums.size - 1])
    else
      subdirs.append(0)
    end
  end
end

puts (sums + subdirs).select { |x| x <= 100_000 }.sum
