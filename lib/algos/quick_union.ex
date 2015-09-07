defmodule Algos.QuickUnion do
  alias Algos.QuickUnion
  defstruct data: %{}

  def new(n) when is_integer(n) do
    initial = 0..n
      |> Enum.reduce(Map.new, fn(i, map) -> map |> Map.put(i, {i, 1}) end)

    %QuickUnion{data: initial}
  end

  def union(%QuickUnion{data: data}, x, y) when is_integer(x) and is_integer(y) do
    {root_x, size_x} = get_root(data, x)
    {root_y, size_y} = get_root(data, y)
    updated_data = if (size_y > size_x) do
      data |> update_root(root_y, root_x, (size_x + size_y))
    else
      data |> update_root(root_x, root_y, (size_x + size_y))
    end
    %QuickUnion{data: updated_data}
  end

  def connected?(%QuickUnion{data: data}, x, y) when is_integer(x) and is_integer(y) do
    root_x = get_root(data, x)
    root_y = get_root(data, y)
    root_x == root_y
  end

  defp get_root(data, i) do
    {parent, size} = data[i]
    if parent == i do
      {parent, size}
    else
      get_root(data, parent)
    end
  end

  defp update_root(data, root, old_root, size) do
    data
      |> Map.put(old_root, {root, 0})
      |> Map.put(root, {root, size})
  end

end
