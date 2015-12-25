title: Functional Programming by Example - Tail Call Optimization
date: 2015-12-24 10:31:37
tags:
- elixir
- functional
- programming
- tail call optimization
---

Since [Elixir](http://elixir-lang.org) came to my attention I really enjoy functional programming.
This series of posts aims to explain some of the terms used in functional programming contexts by using some straight forward and *(hopefully)* interesting examples.
The language of choice is, of course, Elixir*(could you have guessed? =))*.
If you are not familiar with Elixir, I hope you can still follow along, otherwise you might want to take a look at Elixir's excellent [guides](http://elixir-lang.org/getting-started/introduction.html).

## Recursion

When talking about tail call optimization it might be helpful to have a look at what happens when you call a function recursively.
Lets say we have the following function.

``` ruby
defmodule Recur do
  def multiply_forever(a) do
    b = 5
    b * multiply_forever(a)
  end
end
```

I you feel adventurous run this function and see what happens with your RAM usage*(spoiler: it will go up fast)*.

And that's exactly what you expect to happen - a function calls itself forever, every time it uses some memory space for the stack to save what values *a* and *b* hold on each run.

## Tail Call Optimization

Now we are using the same example, with a small modification.

``` ruby
defmodule Recur do
  def multiply_forever(a) do
    b = 5
    multiply_forever(a * b)
  end
end
```

Your RAM usage will not grow indefinitely.
Why?
Because the last thing we called in our function is just the function itself.

> A function is a subject to tail call optimization if the last thing it does is calling itself - *nothing* but itself.

### How does it work?

In the first case the compiler may not know if he needs to keep those *a* and *b* values, so they have to be saved before every new function call.
This might be written down like this:

``` ruby
call multiply_forever(a)
save a,b
call multiply_forever(a)
    save a,b
    call multiply_forever(a)
        save a,b
        call multiply_forever(a)
            save a,b
            call multiply_forever(a)
            ...
```

In contrary, in the second example, the compiler knows, that he only has to care about the new argument to *multiply_forever*.
So he just updates the argument and *JUMPS* back to when *multiply_forever* first got called.
That's the difference  - *JUMP* vs. *CALL*

``` ruby
multiply_forever(a)
jump back to multiply_forever, update what we know about a
jump back to multiply_forever, update what we know about a
jump back to multiply_forever, update what we know about a
jump back to multiply_forever, update what we know about a
...
```

That's basically what you have to know about tail call optimization*(imho)*.
The next section is just for the sake of a more interesting example, feel free to skip it, I hope this article was useful to you.

## A "*real world example*" - writing your own map function

Lets say you want to write your own *Enum* module, it will need a *map* function. So we are going to write it.

First approach that is not suiting tail call optimization:

```ruby
defmodule MyEnum do
  def map([], fun) when is_function(fun), do: []
  def map([head|tail], fun) do
    [fun.(head) | map(tail, fun)]
  end
end
```
Now the *"optimized"* version(*disclaimer: there are better ways to implement this for sure*):

``` ruby
defmodule MyEnum do
  def map(collection, fun) when is function(fun) and is_list(collection) do
    _map(collection, [], fun)
  end

  defp _map([], acc, _fun), do: Enum.reverse(acc) # yeah it's cheating to use Enum here
  defp _map([head|tail], acc, fun) do
    _map(tail, [fun.(head) | acc], fun)
  end
end
```

As you can see, the tail call version takes more code, is not as straight forward as the first approach and we even have to reverse our result.
This is just to show, that even though tail optimization is necessary and you have to use it, sometimes it takes a litte bit more work.


*Merry Christmas*
