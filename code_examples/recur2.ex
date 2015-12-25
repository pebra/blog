defmodule Recur do
  def multiply_forever(a, count) do
    if(count > 20) do
      a
    else
      b = 5
      b * multiply_forever(a, count + 1)
    end
  end
end
