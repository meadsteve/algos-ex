defmodule Algos.QuickUnion do
  alias Algos.QuickUnion
  defstruct data: %{}

  def new(n) when is_integer(n) do
    initial = 0..n
      |> Enum.reduce(Map.new, fn(i, map) -> map |> Map.put(i, i) end)

    %QuickUnion{data: initial}
  end

  def union(%QuickUnion{data: data}, x, y) when is_integer(x) and is_integer(y) do
  
  end

  def connected?(%QuickUnion{data: data}, x, y) when is_integer(x) and is_integer(y) do

  end

end
