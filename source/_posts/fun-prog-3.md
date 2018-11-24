title: Functional Programming by Example - Side Effects
date: 2016-03-20 11:00:00
tags:
- functional programming
- side effects
- Kris Jenkins
---

Long time no see! I want to continue my explorational series of functional programming with **side effects**.
After doing some research I came across [this excellent talk](https://www.youtube.com/watch?v=tQRtTSIpye4) by [Kris Jenkins](http://blog.jenkster.com/) about functional programming.

I my opinion he does an outstanding job in explaining the meaning of side effects and functional programming in general.
So instead of writing a long blog post, I leave you with this talk. Money quotes:

> *Hidden inputs and outputs are called 'side effects'*
>
> *Functional Programming is eliminating & controlling side effects*
>
> -- <cite>Kris Jenkins</cite>

Let me know if things in this talk need clarification!



<!-- First things first - side effects are almost unavoidable in every program that does something in the real world. -->

<!-- So what are side effects after all? -->
<!-- I recently watched [this excellent talk](https://www.youtube.com/watch?v=tQRtTSIpye4) by [Kris Jenkins](http://blog.jenkster.com/) about functional programming. -->
<!-- It gives the best clarification on the terms functional programming and side effects I've seen thus far. -->
<!-- You should definitely watch it. -->

<!-- ### Spot the Side Effect -->

<!-- In the realm of functional programming a function describes a realationship between its inputs and its outputs. -->
<!-- If you give it the same inputs, it will always produce the same outputs. This means that there should be no other dependencies of your function than its inputs. Lets look at this example. -->

<!-- ```ruby -->
<!-- module Moin do -->
<!--   def say_hello(name) do -->
<!--     IO.puts "Hello, #{name}!" -->
<!--   end -->
<!-- end -->
<!-- ``` -->

<!-- Nothing special here, your function takes a name as its input and then prints it to your shell or something like that. -->
<!-- But wait, by printing to the console you actually changed its*(stdout for example)* state! So your function is changing the state of an external resource, that's a side effect. -->

<!-- What about this example: -->

<!-- ```ruby -->
<!-- # example derived from Kris Jenkins' talk - credited in this post -->
<!-- module Foo do -->
<!--   def process_messages(n) do -->
<!--     count = InboxManager.process(n) -->

<!--     count >= 1 -->
<!--   end -->
<!-- end -->
<!-- ``` -->

<!-- Spotted the side effect? -->
<!-- Well there are actually two - one is that your output relies on the state of ```InboxManager``` the other one is that you eventually change its state when calling ```process(n)``` on it. -->
<!-- Therefore this function has one additional hidden input, the state of ```InboxManager``` when it comes in and a hidden output, the state of InboxManager after you called it. -->

<!-- No way you would see this when you didn't know the function body of ```process_messages```. -->

<!-- You can either read along this post or just watch [this excellent talk](https://www.youtube.com/watch?v=tQRtTSIpye4) by [Kris Jenkins](http://blog.jenkster.com/). -->
