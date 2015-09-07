defmodule QuickUnionTest do
  use ExUnit.Case
  alias Algos.QuickUnion

  test "QuickUnion.new doesn't error" do
    result = QuickUnion.new 3
    assert result.data == %{0 => 0, 1 => 1, 2 => 2, 3 => 3}
  end

  test "Points are connected to themselves" do
    data = QuickUnion.new 3
    assert QuickUnion.connected?(data, 1, 1) == true
  end

  test "simple union works" do
    data = QuickUnion.new(10)
      |> QuickUnion.union(0, 1)
    assert QuickUnion.connected?(data, 0, 1) == true
    assert QuickUnion.connected?(data, 0, 2) == false
  end

  test "union chain works" do
    data = QuickUnion.new(10)
      |> QuickUnion.union(0, 1)
      |> QuickUnion.union(1, 2)

    assert QuickUnion.connected?(data, 0, 2) == true
    assert QuickUnion.connected?(data, 0, 3) == false
  end

  test "repition is okay" do
    data = QuickUnion.new(10)
      |> QuickUnion.union(0, 1)
      |> QuickUnion.union(0, 1)

    assert QuickUnion.connected?(data, 0, 1) == true
    assert QuickUnion.connected?(data, 0, 2) == false
  end
end
