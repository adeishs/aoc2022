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

def move(pos, displacement, ubound)
  Complex(
    (pos.real + displacement.real + ubound.real) % ubound.real,
    (pos.imag + displacement.imag + ubound.imag) % ubound.imag
  )
end

tiles, insts = parse($stdin.read)
ubound = Complex((0...tiles.size).map { |r| tiles[r].size }.max, tiles.size)

pos = tiles[0].index { |t| t == TILE[:open] } + 0i
d = 1 + 0i
insts.each do |inst|
  case inst
  when 'L'
    d = Complex(d.imag, -d.real)
  when 'R'
    d = Complex(-d.imag, d.real)
  else
    inst.to_i.times do
      n = move(pos, d, ubound)
      if tiles[n.imag][n.real].nil?
        n = move(n, d, ubound) while tiles[n.imag][n.real].nil?
        pos = n if tiles[n.imag][n.real] == TILE[:open]
      else
        break if tiles[n.imag][n.real] == TILE[:wall]

        pos = n
      end
    end
  end
end
puts 1000 * (pos.imag + 1) + 4 * (pos.real + 1) + FACINGS.index(d)
