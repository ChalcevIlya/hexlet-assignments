# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def test_if_push_works
    expected_result = [4, 6, 3]
    stack = Stack.new
    expected_result.size.times { |i| stack.push!(expected_result[i]) }
    assert { expected_result == stack.to_a }
  end

  def test_if_pop_works
    stack = Stack.new
    3.times { |i| stack.push!(i) }
    3.times { stack.pop! }
    assert { stack.to_a == [] }
  end

  def test_if_clearing_works
    stack = Stack.new
    3.times { |i| stack.push!(i) }
    assert { stack.clear! == [] }
  end

  def test_if_emptyness_check_works
    stack = Stack.new
    3.times { |i| stack.push!(i) }
    refute stack.empty?
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
