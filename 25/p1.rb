#!/usr/bin/env ruby
# frozen_string_literal: true

SNAFU_DEC = %w[= - 0 1 2].map.with_index { |s, i| [s, i - 2] }.to_h
DEC_SNAFU = SNAFU_DEC.map { |k, v| [v, k] }.to_h

def snafu_to_dec(snafu)
  snafu.reverse
       .chars
       .map.with_index { |digit, e| SNAFU_DEC[digit] * (5 ** e) }
       .reduce(*:+)
end

def dec_to_snafu(dec)
  snafu = []
  e = Math.log(dec, 5).floor
  rem = dec
  until e < 0
    p = 5 ** e
    d = (rem <=> 0) * (1.0 * rem.abs / p).round

    snafu << DEC_SNAFU[d]

    rem -= d * p
    e -= 1
  end

  snafu.join('')
end

puts dec_to_snafu($stdin.each_line
                        .map { |s| snafu_to_dec(s.chomp) }
                        .reduce(*:+))
