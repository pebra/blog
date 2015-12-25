defmodule MyEnum do

  def map(collection, fun) when is_function(fun) and is_list(collection) do
    _map(collection, [], fun)
  end

  defp _map([], acc, _fun), do: Enum.reverse(acc) # I know, it's cheating, but writing own reverse is out of scope
  defp _map([head|tail], acc, fun) do
    _map(tail, [fun.(head) | acc], fun)
  end

  def lmap([], fun) when is_function(fun), do: []
  def lmap([head|tail], fun) do
    [fun.(head) | lmap(tail, fun)]
  end
end
