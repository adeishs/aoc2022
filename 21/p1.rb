#!/usr/bin/env ruby
# frozen_string_literal: true

class Monkey
  attr_reader :name
  attr_accessor :operator, :operands, :value

  def initialize(name, args)
    @name = name
    if args.size == 1
      @value = args[0]
    else
      @operator = args[1]
      @operands = [args[0], args[2]]
    end
  end
end

def parse(line)
  name, arg_str = line.split(' ', 2)
  args = arg_str.split
  args[0] = args[0].to_i if args.size == 1
  name = name.sub(':', '')

  [name, Monkey.new(name, args)]
end

def resolvable(monkey, value_monkey)
  monkey.operands.all? { |o| value_monkey.include?(o) }
end

monkey = { operator: Hash[$stdin.each_line.map { |line| parse(line.chomp) }] }
monkey[:value] = monkey[:operator].reject { |_, m| m.value.nil? }
monkey[:operator].keep_if { |_, m| m.value.nil? }
until monkey[:operator].empty?
  monkey[:operator].select { |_, m| resolvable(m, monkey[:value]) }
                   .each do |n, m|
    m.value = monkey[:value][m.operands.shift].value.send(
      m.operator, monkey[:value][m.operands.shift].value
    )
    monkey[:value][n] = m
    monkey[:operator].delete(n)
  end
end
puts monkey[:value]['root'].value
