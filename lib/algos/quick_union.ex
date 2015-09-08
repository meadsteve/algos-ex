defmodule Algos.QuickUnion do
  alias Algos.QuickUnion
  defstruct data: %{}

  def new(n) when is_integer(n) do
    initial = 0..n
      |> Enum.reduce(Map.new, fn(i, map) -> map |> Map.put(i, {i, 1}) end)

    %QuickUnion{data: initial}
  end

  def union(%QuickUnion{data: data}, x, y) when is_integer(x) and is_integer(y) do
    {root_x, size_x, nodes_touched_x} = get_root(data, x)
    {root_y, size_y, nodes_touched_y} = get_root(data, y)
    if (size_y > size_x) do
      new_root_data = {root_y, (size_x + size_y)}
      old_root = root_x
    else
      new_root_data = {root_x, (size_x + size_y)}
      old_root = root_y
    end
    updated_data = data
      |> update_root(old_root, new_root_data)
      |> compress(nodes_touched_x, new_root_data)
      |> compress(nodes_touched_y, new_root_data)

    %QuickUnion{data: updated_data}
  end

  def connected?(%QuickUnion{data: data}, x, y) when is_integer(x) and is_integer(y) do
    {root_x, _, _} = get_root(data, x)
    {root_y, _, _} = get_root(data, y)
    root_x == root_y
  end

  defp get_root(data, i, nodes_touched \\ []) do
    {parent, size} = data[i]
    if parent == i do
      {i, size, nodes_touched}
    else
      get_root(data, parent, [ i | nodes_touched])
    end
  end

  defp update_root(data, old_root, {root, size}) do
    data
      |> Map.put(old_root, {root, 0})
      |> Map.put(root, {root, size})
  end

  defp compress(data, nodes, {root, size}) do
    nodes
      |> Enum.reduce(data, fn(i, map) -> map |> Map.put(i, {root, size}) end)
  end

end
