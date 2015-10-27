---
layout: post
title: "Find all records associated with an ActiveRecord::Base model"
date: 2013-09-09 21:54
comments: true
tags: 
- ruby
- ruby on rails
- activerecord
---

If you are too lazy to look up the source file, just hit this up in the rails console.

``` ruby
InterestingModel.reflect_on_all_associations.map{ |assoc| [assoc.macro, assoc.name] }
  # =>[[:belongs_to, :foo_model],
  #    [:has_one, :bar_model],
  #    [:has_one, :other_model]
  #=> ActiveRecord::Reflection::AssociationReflection

```


*Addtion:*
You can also see all associations for an instance of a model.

``` ruby
InterestingModel.new.reflections
  #=> ActiveRecord::Reflection::AssociationReflection
```

This also works with Classes themself

``` ruby
InterestingModel.reflections
  #=> ActiveRecord::Reflection::AssociationReflection
```

Note that *reflect_on_all_associations* returns an Array of all Associations and
*reflections* will return a Hash like *{ :association_name => ActiveRecord::Relfection::AssociationReflection }*
