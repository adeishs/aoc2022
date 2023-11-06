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
      @operator = @name == 'root' ? '-' : args[1]
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

  resolve_monkey(monkey, m.operands.first).send(
    m.operator, resolve_monkey(monkey, m.operands.last)
  )
end

monkey = Hash[$stdin.each_line.map { |line| parse(line.chomp) }]
prev_humn_val = monkey['humn'].value
prev_err = resolve_monkey(monkey, 'root').abs
curr_humn_val = 0
monkey['humn'].value = 0
curr_err = resolve_monkey(monkey, 'root').abs

# use gradient descent
until curr_err < 0.1
  d = curr_err - prev_err
  grad = if d.zero?
           d.negative? ? 1 : -1
         else
           (curr_humn_val - prev_humn_val) / d
         end

  prev_humn_val = curr_humn_val
  prev_err = curr_err

  curr_humn_val -= 0.05 * grad * curr_err
  monkey['humn'].value = curr_humn_val.round

  curr_err = resolve_monkey(monkey, 'root').abs
end

puts monkey['humn'].value
