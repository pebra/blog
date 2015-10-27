---
layout: post
title: "How to get recipes from chefkoch.de using ruby | Part 1"
date: 2012-10-31 14:50
comments: true
tags:
- coding
- ruby
- chefkoch.de
- api
- cooking
---

Driven by a seminar task at university we were free to create any kind of web/android/iphone app which takes care of
some contextual issues.

As I am a huge fan of Ruby and Ruby on Rails I convinced my partner to develop a web app for this seminar.

Since we both like to cook, we decided to create a web app with RoR which helps you to find a suitable recipe for
the ingedrients which are already present at your home.

To get us started finding some database we can work on, I stumbled across the ChefkochApi.
It's fairly easy to interact with, you just search for lets say "apple pie" by firing this request:

``` bash
http://api.chefkoch.de/api/1.1/api-recipe-search.php?Suchbegriff=apple%20pie&i=0&z=1&m=0&o=0&t=&limit=2
```

... and will get a response like this one:

``` javascript
{"spellcheck":"","api":{"version":1.1},"total":48,
  "result":[
    {
      "RezeptID":52749,
      "RezeptShowID":"527491149183211",
      "RezeptName":"Apple Pie",
      "RezeptName2":"Apfel \u0096Pie",
      "Minuten":30,
      "Bild":true,
      "Datum":"2006-06-01T19:36:12Z",
      "SchwierigkeitsgradName":"simpel",
      "user_id":"8617bcc7ecc7909ad61f52a52337f763",
      "uservote_img":"3_5",
      "RezeptBild":
      "http:\/\/cdn.chefkoch.de\/ck.de\/rezepte\/52\/52749\/36051-thumbfix-apple-pie.jpg"},

    {
      "RezeptID":101077,
      "RezeptShowID":"1010771206206427",
      "RezeptName":"Apple Pie",
      "RezeptName2":"Mehl, Butter, Zucker, Zitronenschale (oder wahlweise eine Packung Citroback), Salz und die Eigelbe mischen und zu einem Teig ...",
      "Minuten":45,
      "Bild":false,
      "Datum":"2008-03-27T18:58:17Z",
      "SchwierigkeitsgradName":"simpel",
      "user_id":"3733fd403a13fb5f951c2369ae1acd22",
      "uservote_img":"3_5"}
  ]}
```
And this is how you can access the API with Ruby:

``` ruby
require 'net/http'
require 'json'
require 'uri'

module ChefkochApi
  @api_url = "http://api.chefkoch.de/api/1.0/api-recipe-search.php"

  def self.search(search_text)
    params = {}
    params["Suchbegriff"] = search_text.strip
    # params["limit"] = 20 # you can pass the limit amount of results you like to receive

    url = URI.parse @api_url
    url.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(url)
    response.body
    end
  end
```

Now you can invoke a recipe search by simply calling

``` ruby
ChefkochApi.search("apple pie")
```

That's it for part one. In the next part I will try to modify the result and retrieve more detailed information from it like
ingredients and stuff.

