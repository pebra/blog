title: Functional Programming by Example - Higher Order Functions
date: 2015-12-25 11:55:04
tags:
- functional
- programming
- higher order functions
- elixir
- learning
---

In my [previous post](http://www.pebra.net/blog/2015/12/24/fun-prog-1/) I tried to explain tail call optimization.
If you read it to the end you saw that *map* function that took a collection and a function as its arguments.
This already was a higher order function. The definition is straight forward:
> *A higher order function takes a function as an argument or returns a function as its result, or both.*

So lets say you work in a big company and you have to calculate the bonuses for the employees. Of course, not everyone gets the same bonus, but you're too lazy to pass the specific multiplier at every calculation. So you create seperate functions.
In this example the C-level department members get a bonus of 1.5 of their annual salary. While the salaries may differ, the multiplier stays the same.

``` ruby
defmodule Salary do
  def bonus_calculation(percentage) do
    fn(salary) -> salary * percentage end
  end
end

# c_level_bonuses = Salary.bonus_calculation(1.5)
# c_level_bonuses.(100_000)
# => 150000.0
```

You may be wondering, why our *c_level_bonuses* function still knows about the percentage since we haven't explicitly passed that value.
That's because the function has knowledge about the environment it was created in - it's a [closure](https://en.wikipedia.org/wiki/Closure_%28computer_programming%29).

If you want to see an example for a function that takes another function as an argument, head to my [previous post](http://www.pebra.net/blog/2015/12/24/fun-prog-1/#A_“real_world_example“_-_writing_your_own_map_function) and take a look at the *map* function.

And in case you feel adventurous, try to find a use case to write a function that takes *and* returns a function =)
