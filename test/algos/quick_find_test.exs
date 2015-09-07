defmodule QuickFindTest do
  use ExUnit.Case
  alias Algos.QuickFind

  test "QuickFind.new doesn't error" do
    result = QuickFind.new 3
    assert result.data == %{0 => 0, 1 => 1, 2 => 2, 3 => 3}
  end

  test "Points are connected to themselves" do
    data = QuickFind.new 3
    assert QuickFind.connected?(data, 1, 1) == true
  end

  test "simple union works" do
    data = QuickFind.new(10)
      |> QuickFind.union(0, 1)
    assert QuickFind.connected?(data, 0, 1) == true
    assert QuickFind.connected?(data, 0, 2) == false
  end

  test "union chain works" do
    data = QuickFind.new(10)
      |> QuickFind.union(0, 1)
      |> QuickFind.union(1, 2)

    assert QuickFind.connected?(data, 0, 2) == true
    assert QuickFind.connected?(data, 0, 3) == false
  end

  test "repition is okay" do
    data = QuickFind.new(10)
      |> QuickFind.union(0, 1)
      |> QuickFind.union(0, 1)

    assert QuickFind.connected?(data, 0, 1) == true
    assert QuickFind.connected?(data, 0, 2) == false
  end
end
