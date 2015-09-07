defmodule Algos.QuickUnion do
  alias Algos.QuickUnion
  defstruct data: %{}

  def new(n) when is_integer(n) do
    initial = 0..n
      |> Enum.reduce(Map.new, fn(i, map) -> map |> Map.put(i, i) end)

    %QuickUnion{data: initial}
  end

  def union(%QuickUnion{data: data}, x, y) when is_integer(x) and is_integer(y) do
    root_x = get_root(data, x)
    root_y = get_root(data, y)
    updated_data = Map.put(data, root_x, root_y)
    %QuickUnion{data: updated_data}
  end

  def connected?(%QuickUnion{data: data}, x, y) when is_integer(x) and is_integer(y) do
    root_x = get_root(data, x)
    root_y = get_root(data, y)
    root_x == root_y
  end

  defp get_root(data, i) do
    parent = data[i]
    if parent == i do
      i
    else
      get_root(data, parent)
    end
  end

end
