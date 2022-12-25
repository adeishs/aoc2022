#!/usr/bin/env ruby
# frozen_string_literal: true

SNAFU_DEC = %w[= - 0 1 2].map.with_index { |s, i| [s, i - 2] }.to_h
DEC_SNAFU = SNAFU_DEC.keys.rotate(2)

def snafu_to_dec(snafu)
  snafu.reverse
       .chars
       .map.with_index { |digit, e| SNAFU_DEC[digit] * (5 ** e) }
       .reduce(*:+)
end

def dec_to_snafu(dec)
  snafu = []
  until dec.zero?
    snafu << DEC_SNAFU[dec % 5]
    dec = dec / 5 + (%w[= -].include?(snafu.last) && 1 || 0)
  end

  snafu.reverse.join('')
end

puts dec_to_snafu($stdin.each_line
                        .map { |s| snafu_to_dec(s.chomp) }
                        .reduce(*:+))
