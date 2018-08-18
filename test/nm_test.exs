defmodule NmTest do
  use ExUnit.Case
  doctest Nm

  test "test remove object" do
    {s, t, b} = Nm.remove_object(10, 0)
    assert s == 10
    assert String.starts_with?(t, "Invalid move") == true
    assert b == false

    {s, t, b} = Nm.remove_object(10, 6)
    assert s == 10
    assert String.starts_with?(t, "Invalid move") == true
    assert b == false

    {s, t, b} = Nm.remove_object(10, 11)
    assert s == 10
    assert String.starts_with?(t, "Invalid move") == true
    assert b == false

    {s, t, b} = Nm.remove_object(10, 4)
    assert s == 6
    assert String.starts_with?(t, "Ok") == true
    assert b == true
  end

  test "generate move" do
    assert Nm.generate_move(10) > 0
    assert Nm.generate_move(10) < 6
  end

  test "validate input" do
    assert Nm.validate_input("\n") == :error
    assert Nm.validate_input("foo\n") == :error
    assert Nm.validate_input("10.1\n") == :error
    assert Nm.validate_input("10\n") == 10
  end

  test "make move" do
    assert Nm.make_move(2, 10) == 8
  end
end
