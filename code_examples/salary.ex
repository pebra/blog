defmodule Salary do
  def bonus_calculation(percentage) do
    fn(salary) -> salary * percentage end
  end
end
