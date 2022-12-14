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
    coords << curr
  end
  coords
end

def parse(line)
  line.chomp
      .split(' -> ')
      .map { |c| c.split(',') }
      .map { |x, y| Complex(x.to_i, y.to_i) }
      .each_cons(2)
      .map { |src, dest| gen_coords(src, dest) }
end

def add_base(rocks)
  rocks_a = rocks.to_a

  base_y = rocks_a.map { |r| r.imag }.max
  base_x_min, base_x_max = rocks_a.select { |r| r.imag == base_y }
                                  .map { |r| r.real }.minmax
  base_y += 2
  rocks.merge(
    (base_x_min - base_y..base_x_max + base_y).map { |x| Complex(x, base_y) }
  )
end

def run(rocks)
  add_base(rocks)
  num_of_units = 0
  loop do
    curr = SAND_SRC
    break if rocks.include?(curr)

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
      else
        curr += FALL_DIR[:D]
      end
    end
  end

  num_of_units
end

puts run(Set.new($stdin.each_line.map { |line| parse(line) }.flatten.uniq))
