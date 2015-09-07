defmodule QuickUnionTest do
  use ExUnit.Case
  alias Algos.QuickUnion

  test "QuickUnion.new doesn't error" do
    result = QuickUnion.new 3
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
    set = QuickUnion.new(10)
      |> QuickUnion.union(1, 2)
      |> QuickUnion.union(2, 4)
      |> QuickUnion.union(5, 0)
      |> QuickUnion.union(0, 1)

    assert QuickUnion.connected?(set, 0, 2) == true
    assert QuickUnion.connected?(set, 0, 3) == false
    # 5 nodes are connected together with 1 as the root
    # so the following assertion should be true
    assert set.data[1] == {1, 5}
  end

  test "repition is okay" do
    data = QuickUnion.new(10)
      |> QuickUnion.union(0, 1)
      |> QuickUnion.union(0, 1)

    assert QuickUnion.connected?(data, 0, 1) == true
    assert QuickUnion.connected?(data, 0, 2) == false
  end
end
