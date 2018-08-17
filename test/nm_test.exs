defmodule NmTest do
  use ExUnit.Case
  doctest Nm

  test "greets the world" do
    assert Nm.hello() == :world
  end
end
