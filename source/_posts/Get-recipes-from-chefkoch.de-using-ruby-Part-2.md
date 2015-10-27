---
layout: post
title: "Get recipes from chefkoch.de using ruby | Part 2"
date: 2013-03-13 11:20
comments: true
tags:
- coding
- ruby
- chefkoch.de
- api
- cooking
---

Even it's quite a while ago since part 1, I want to finish up this micro series about the chefkoch api.
As you may remember, we are able to search for recipes, whose titles are matching our search string.
Unfortunatly, the api response is not serving any link to the recipe itself.
So let's fix this and add this url directly to our method's result!

First we need to find out, how the recipe urls are built.
By checking some recipes on their site, we can see that recipe urls are built like that:

``` bash

  http://www.chefkoch.de/rezepte/:id

```

Now we could extend our search method by telling it to call a method named "append_recipe_link" and passing our response to that method:

``` ruby
require 'net/http'
require 'json'
require 'uri'

module ChefkochApi
  @api_url = "http://api.chefkoch.de/api/1.0/api-recipe-search.php"
  @rezept_url = "http://www.chefkoch.de/rezepte/" # this is new

  def self.search(search_text)
    # ... stil the same stuff
    response = Net::HTTP.get_response(url)

    self.append_recipe_link response
  end

  private

  # our new helper method
  def self.append_recipe_link(response)
    # here comes some JSON magic to extract only the relevant information from the json response
    JSON.parse(response.body.strip)["result"].each do |r|
      r["RezeptUrl"] = @rezept_url + r["RezeptShowID"]
    end
  end
end

```
And there you go. Your results should now have a url linking directly to the recipe show page.


The last thing I want to show is, how you get more detailed information about your recipes.
I am using another method for that, which does another api call. Please note the aditional api url at the top.

``` ruby

require 'net/http'
require 'json'
require 'uri'

module ChefkochApi
  @api_url = "http://api.chefkoch.de/api/1.0/api-recipe-search.php"
  @api_rezept_url = "http://api.chefkoch.de/api/1.0/api-recipe.php"
  @rezept_url = "http://www.chefkoch.de/rezepte/"

  def self.search(search_text)
    # ...
  end

  # here we go
  def self.show_recipe(id)
    # Remember "RezeptShowID" from our JSON response?
    # Thats the id which gets passed to this method here
    params = {}
    params["ID"] = id

    url = URI.parse @api_rezept_url
    url.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(url)
    JSON.parse(response.body.strip)["result"]
  end

  private

  def self.append_recipe_link(response)
    # ...
  end
end

```

This gives us more detailed information about a recipe in response:

``` javascript
{
  "api":{
    "version":1.2
  },
    "total":1,
    "result":[
    {
      "rezept_id":"101077",
      "rezept_show_id":"1010771206206427",
      "rezept_name":"Apple Pie",
      "rezept_name2":"",
      "rezept_zubereitung":"Mehl, Butter, Zucker, Zitronenschale (oder wahlweise eine Packung Citroback), Salz und die Eigelbe mischen und zu einem Teig verkneten. \r\n\r\nDie \u00c4pfel sch\u00e4len und in St\u00fccke schneiden, mit etwas Zucker und Wasser in einem Topf 5 min. kochen lassen (nach Geschmack noch ein wenig zerdr\u00fccken), die Masse abk\u00fchlen lassen. \r\n\r\nDen Teig in zwei St\u00fccke teilen. Den gr\u00f6\u00dferen Teil ausrollen und die Form (ca 20 cm Durchmesser) damit auslegen. Nun die abgek\u00fchlte Masse auf dem Teig verteilen. Den Rest des Teiges ausrollen und oben auf die Apfelmasse legen. An den Seiten andr\u00fccken. Das Ganze wird nun mit einem Eigelb (gemischt mit etwas Wasser) bestrichen.\r\n\r\nDas Ganze im vorgeheizten Ofen bei 180\u00b0C 45 \u0096 50 min. backen lassen. Am besten noch warm genie\u00dfen.",
      "rezept_portionen":"1",
      "rezept_preparation_time":45,
      "rezept_cooking_time":0,
      "rezept_resting_time":60,
      "rezept_schwierigkeit":"simpel",
      "rezept_kcal":"0",
      "rezept_user_id":"3733fd403a13fb5f951c2369ae1acd22",
      "rezept_user_name":"KaThePrincess",
      "rezept_datum":"1206640697",
      "rezept_videos":[

        ],
      "rezept_in_rezeptsammlung":[
      {
        "sammlungs_id":"946538",
        "sammlungs_name":"Apfelkuchen",
        "sammlungs_link":"\/rezeptsammlung\/946538\/Apfelkuchen.html"
      },
      {
        "sammlungs_id":"1803978",
        "sammlungs_name":"Kuchen und andere s\u00fc\u00dfe sachen",
        "sammlungs_link":"\/rezeptsammlung\/1803978\/Kuchen-und-andere-suesse-sachen.html"
      }
      ],
        "rezeptsammlungen_link":"\/rezeptsammlung\/0,30\/1010771206206427\/",
        "rezept_zutaten_is_basic":[
          "71",
        "70",
        "83",
        "6",
        "247"
          ],
        "rezept_zutaten":[
        {
          "id":"71",
          "name":"Mehl",
          "eigenschaft":"",
          "cominfo":"0",
          "ist_basic":"1",
          "menge":"225",
          "einheit":"g",
          "menge_berechnet":225,
          "has_additional_info":false
        },
        {
          "id":"70",
          "name":"Butter",
          "eigenschaft":"",
          "cominfo":"0",
          "ist_basic":"1",
          "menge":"140",
          "einheit":"g",
          "menge_berechnet":140,
          "has_additional_info":false
        },

      and so on and so on ...

      ],
        "rezept_tags":[
          "Backen",
        "Kuchen",
        "USA oder Kanada",
        "Weihnachten"
          ],
        "rezept_user_portionen":"1",
        "rezept_votes":{
          "average":3.3333,
          "img":"3_5",
          "votes":"1",
          "result":"5"
        },
        "rezept_statistik":{
          "total":{
            "viewed":"4095",
            "saved":"12",
            "printed":"71",
            "mailed":"1"
          },
          "month":{
            "viewed":"16",
            "saved":"0",
            "printed":"1",
            "mailed":"0"
          }
        },
        "rezept_frontend_url":"http:\/\/www.chefkoch.de\/rezepte\/1010771206206427\/Apple-Pie.html"
    }
  ]
}
```

Now our module has quite some functionality. Hope this was usefull for at least a few people.
