#!/usr/bin/env ruby
# frozen_string_literal: true

TILE = {
  open: '.',
  wall: '#',
  off: ' '
}.freeze

FACINGS = [1 + 0i, 0 + 1i, -1 + 0i, 0 - 1i].freeze

def parse_tile(tile_str)
  tile_str.split("\n")
          .map do |line|
    line.chomp
        .split('')
        .map { |t| t == TILE[:off] ? nil : t }
  end
end

def parse_insts(inst_str)
  inst_str.split(/[LR]/).zip(
    inst_str.split('').select { |i| %w[L R].include?(i) }
  ).flatten.reject(&:nil?)
end

def parse(input)
  tile_str, inst_str = input.split("\n\n")

  [parse_tile(tile_str), parse_insts(inst_str)]
end

def move(pos, d, num_of_rows, num_of_cols)
  pos += d
  pos = Complex((pos.real + num_of_cols) % num_of_cols, pos.imag) unless pos.real.between?(0, num_of_cols - 1)
  pos = Complex(pos.real, (pos.imag + num_of_rows) % num_of_rows) unless pos.imag.between?(0, num_of_rows - 1)

  pos
end

tiles, insts = parse($stdin.read)
num_of_rows = tiles.size
num_of_cols = (0...num_of_rows).map { |r| tiles[r].size }.max

pos = tiles[0].index { |t| t == TILE[:open] } + 0i
d = 1 + 0i
insts.each do |inst|
  case inst
  when 'L'
    d = Complex(d.imag, -d.real)
  when 'R'
    d = Complex(-d.imag, d.real)
  else
    (1..inst.to_i).each do |_i|
      n = move(pos, d, num_of_rows, num_of_cols)
      nt = tiles[n.imag][n.real]
      if nt.nil?
        n = move(n, d, num_of_rows, num_of_cols) while tiles[n.imag][n.real].nil?

        pos = n if tiles[n.imag][n.real] == TILE[:open]
      else
        break if nt == TILE[:wall]

        pos = n
      end
    end
  end
end
puts 1000 * (pos.imag + 1) + 4 * (pos.real + 1) + FACINGS.index(d)
