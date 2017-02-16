defmodule UphillRating.CalculateTest do
  use ExUnit.Case

  test "correct climb_coeff calculation" do
    assert Calculate.climb_coeff(9) == 0.1
    assert Calculate.climb_coeff(10) == 0.2
    assert Calculate.climb_coeff(20) == 0.3
    assert Calculate.climb_coeff(30) == 0.4
    assert Calculate.climb_coeff(90) == 1.0
    assert Calculate.climb_coeff(99) == 1.0
    assert Calculate.climb_coeff(100) == 1.1
    assert Calculate.climb_coeff(199) == 1.1
    assert Calculate.climb_coeff(200) == 1.2
    assert Calculate.climb_coeff(299) == 1.2
    assert Calculate.climb_coeff(900) == 1.9
    assert Calculate.climb_coeff(999) == 1.9
  end
end
