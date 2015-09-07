defmodule Algos.QuickFind do
  alias Algos.QuickFind
  defstruct data: %{}

  def new(n) when is_integer(n) do
    initial = 0..n
      |> Enum.reduce(Map.new, fn(i, map) -> map |> Map.put(i, i) end)

    %QuickFind{data: initial}
  end

  def union(%QuickFind{data: data}, x, y) when is_integer(x) and is_integer(y) do
    x_id = Map.get(data, x)
    y_id = Map.get(data, y)
    updated_data = data |> update_ids(x_id, y_id)
    %QuickFind{data: updated_data}
  end

  def connected?(%QuickFind{data: data}, x, y) when is_integer(x) and is_integer(y) do
    x_id = Map.get(data, x)
    y_id = Map.get(data, y)

    x_id == y_id
  end

  defp update_ids(data, same_id, same_id), do: data
  
  defp update_ids(data, old_id, new_id) do
    data |> Enum.reduce(Map.new, fn
      ({i, id}, map) when id == old_id -> map |> Map.put(i, new_id)
      ({i, unchanged_id}, map)         -> map |> Map.put(i, unchanged_id)
    end)
  end

end
