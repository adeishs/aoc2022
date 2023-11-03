#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_monkey(monkey_spec)
  lines = monkey_spec.split("\n").map(&:strip)

  # ignore index — the input is always sorted
  _ = lines.shift

  _, tmp = lines.shift.split(': ')
  monkey = { items: tmp.split(', ').map(&:to_i) }

  monkey[:operator], tmp = lines.shift.sub('Operation: new = old ', '').split
  monkey[:operand] = tmp == 'old' ? nil : tmp.to_i

  monkey[:test_div] = lines.shift.sub('Test: divisible by ', '').to_i
  monkey[:target] = {
    true => lines.shift.sub('If true: throw to monkey ', '').to_i,
    false => lines.shift.sub('If false: throw to monkey ', '').to_i
  }

  monkey[:inspect_count] = 0

  monkey
end

monkeys = $stdin.read.split("\n\n").map { |spec| parse_monkey(spec) }

20.times do
  monkeys.each do |monkey|
    monkey[:inspect_count] += monkey[:items].size

    monkey[:items].size.times do
      worry_level = monkey[:items].shift

      if monkey[:operator] == '+'
        worry_level += monkey[:operand]
      else
        worry_level *= monkey[:operand] || worry_level
      end
      worry_level /= 3

      target = monkey[:target][(worry_level % monkey[:test_div]).zero?]
      monkeys[target][:items].push(worry_level)
    end
  end
end

puts monkeys.map { |m| m[:inspect_count] }.sort.pop(2).reduce(1, :*)
