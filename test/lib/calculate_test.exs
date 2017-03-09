defmodule UphillRating.CalculateTest do
  use ExUnit.Case

  test "correct climb_coeff calculation" do
    assert Calculate.climb_coeff(9) == 0.1
    assert Calculate.climb_coeff(10) == 0.2
    assert Calculate.climb_coeff(20) == 0.3
    assert Calculate.climb_coeff(30) == 0.4
    assert Calculate.climb_coeff(89) == 0.9
    assert Calculate.climb_coeff(90) == 1.0
    assert Calculate.climb_coeff(99) == 1.0
    assert Calculate.climb_coeff(100) == 1.1
    assert Calculate.climb_coeff(199) == 1.1
    assert Calculate.climb_coeff(200) == 1.2
    assert Calculate.climb_coeff(299) == 1.2
    assert Calculate.climb_coeff(900) == 1.9
    assert Calculate.climb_coeff(999) == 1.9
  end

  test "correct calculate_points" do
    assert Calculate.calculate_points(0, 31) == 30
    assert Calculate.calculate_points(1, 31) == 27
    assert Calculate.calculate_points(2, 31) == 24
    assert Calculate.calculate_points(3, 31) == 22
    assert Calculate.calculate_points(4, 31) == 21
    assert Calculate.calculate_points(5, 31) == 20
    assert Calculate.calculate_points(6, 31) == 19
    assert Calculate.calculate_points(7, 31) == 18
    assert Calculate.calculate_points(8, 31) == 17
    assert Calculate.calculate_points(9, 31) == 16
    assert Calculate.calculate_points(10, 31) == 15
    assert Calculate.calculate_points(11, 31) == 14
    assert Calculate.calculate_points(12, 31) == 13
    assert Calculate.calculate_points(13, 31) == 12
    assert Calculate.calculate_points(14, 31) == 11
    assert Calculate.calculate_points(15, 31) == 10
    assert Calculate.calculate_points(16, 31) == 9
    assert Calculate.calculate_points(17, 31) == 8
    assert Calculate.calculate_points(18, 31) == 7
    assert Calculate.calculate_points(19, 31) == 6
    assert Calculate.calculate_points(20, 31) == 5.58
    assert Calculate.calculate_points(21, 31) == 5.17
    assert Calculate.calculate_points(22, 31) == 4.75
    assert Calculate.calculate_points(23, 31) == 4.33
    assert Calculate.calculate_points(24, 31) == 3.92
    assert Calculate.calculate_points(25, 31) == 3.5
    assert Calculate.calculate_points(26, 31) == 3.08
    assert Calculate.calculate_points(27, 31) == 2.67
    assert Calculate.calculate_points(28, 31) == 2.25
    assert Calculate.calculate_points(29, 31) == 1.83
    assert Calculate.calculate_points(30, 31) == 1.42
  end
end
