#!/usr/bin/env ruby

require 'terminal-table'


class NumBlock
  def initialize(target_num)
    @target = target_num.to_i
  end

  def flat_array
    (1..@target).to_a
  end
  
  def to_s
    Terminal::Table.new(rows: to_a, style: style).to_s
  end

  def style
    { alignment: :right, padding_left: 1, padding_right: 0, border_x: '', border_y: '', border_i: '' }
  end

  def to_a
    [].tap do |out|
      flat_array.each_with_index do |num, i|
        out[i / 10] ||= []
        out[i / 10] << num
      end
    end
  end

end

ARGV.each do |num|
  puts "-------------------------\n"
  puts num + "\n\n"
  puts NumBlock.new(num)
end

