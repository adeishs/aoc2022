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

def resolve_monkey(monkey, name)
  m = monkey[name]
  return m.value unless m.value.nil?

  return resolve_monkey(monkey, m.operands.first).send(
    m.operator, resolve_monkey(monkey, m.operands.last)
  )
end

monkey = Hash[$stdin.each_line.map { |line| parse(line.chomp) }]
puts resolve_monkey(monkey, 'root')
