class My_array
  def initialize(array)

    @array = array.dup.freeze

  end

  def elements

    @array

  end

  def find_all

    return enum_for(:find_all) unless block_given?

    result = []
    for element in @array
      result << element if yield(element)
    end
    result

  end

 def min_max
    return enum_for(:min_max) unless block_given?

    min = nil
    max = nil

    for element in @array
      min = element if min.nil? || yield(element, min) < 0
      max = element if max.nil? || yield(element, max) > 0
    end

    [min, max]
  end

  def reduce(initial = nil)

    return enum_for(:reduce) unless block_given?

    accumulator = initial
    for element in @array
      accumulator = accumulator.nil? ? element : yield(accumulator, element)
    end
    accumulator

  end


  def none?

    return enum_for(:none?) unless block_given?

    for element in @array
      return false if yield(element)
    end
    true

  end

  def find_index

    return enum_for(:find_index) unless block_given?

    for index in 0...@array.size
      return index if yield(@array[index])
    end
    nil

  end

  def any?

    return enum_for(:any?) unless block_given?

    for element in @array
      return true if yield(element)
    end
    false

  end

end


require 'minitest/autorun'

class My_array_test < Minitest::Test

  def setup

    @array = [1, 2, 3, 4, 5, 6]
    @test = My_array.new(@array)

  end

  def test_elements

    assert_equal @array, @test.elements

  end

  def test_find_all

    assert_equal [2, 4, 6], @test.find_all { |x| x.even? }

  end

  def test_min_max

    assert_equal [1, 6], @test.min_max { |a, b| a <=> b }

  end

  def test_reduce

    assert_equal 21, @test.reduce { |sum, x| sum + x }
    assert_equal 720, @test.reduce(1) { |prod, x| prod * x }

  end

  def test_none

    assert @test.none? { |x| x > 10 }
    refute @test.none? { |x| x > 3 }

  end

  def test_find_index

    assert_equal 1, @test.find_index { |x| x == 2 }
    assert_nil @test.find_index { |x| x == 10 }

  end

  def test_any

    assert @test.any? { |x| x.even? }
    refute @test.any? { |x| x > 10 }

  end

end