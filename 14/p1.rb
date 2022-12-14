#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

SAND_SRC = 500 + 0i
FALL_DIR = {
  D: 0 + 1i,
  L: -1 + 1i,
  R: 1 + 1i
}.freeze

def get_dir(src, dest)
  if src.real == dest.real
    return 0 + 1i if src.imag < dest.imag

    0 - 1i
  else
    return 1 + 0i if src.real < dest.real

    -1 + 0i
  end
end

def gen_coords(src, dest)
  coords = [src]
  d = get_dir(src, dest)

  curr = src
  while curr != dest
    curr += d
    coords.append(curr)
  end
  coords
end

def parse(line)
  line.chomp
      .split(' -> ')
      .map { |c| c.split(',') }
      .map { |x, y| x.to_i + y.to_i * (0 + 1i) }
      .each_cons(2)
      .map { |src, dest| gen_coords(src, dest) }
end

def run(rocks)
  num_of_units = 0
  abyss = false
  until abyss
    curr = SAND_SRC

    loop do
      if rocks.include?(curr + FALL_DIR[:D])
        if rocks.include?(curr + FALL_DIR[:L])
          if rocks.include?(curr + FALL_DIR[:R])
            rocks << curr
            num_of_units += 1
            break
          else
            curr += FALL_DIR[:R]
          end
        else
          curr += FALL_DIR[:L]
        end
      elsif rocks.to_a
                 .find { |r| r.real == curr.real && r.imag > curr.imag }
        curr += FALL_DIR[:D]
      else
        abyss = true
        break
      end
    end
  end

  num_of_units
end

puts run(Set.new($stdin.each_line.map { |line| parse(line) }.flatten.uniq))
