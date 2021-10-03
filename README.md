# Weather Monitor

This application is a demo project that I’ve written to learn the Dart programming language and get basics of Flutter.
This application uses using http://www.pogodaiklimat.ru/ web resource to get information about the weather.
I’ve not found any web API provided by this web resource, so I decided just to parse their web page and get data from HTML markup.
Note that it can be broken in the future if they change their HTML markup.    

Now the app supports two locales: *English* and *Russian*.

The information about countries and cities is stored in *locations.json* file that is bundled inside this project in *assets* folder.

It has the following format:

```
[
  {
    "id": 1000,
    "name": {
      "en": "Ukraine",
      "ru": "Украина"
    },
    "assetName": "ukraine-flag-square-xs",
    "cities": [
      {
        "id": 33345,
        "name": {
          "en": "Kyiv",
          "ru": "Киев"
        }
      },
      ...
    ]
 }
 ...
]
```

* country **id** is a just arbitrary identifier
* country **name** is a name with two possible variants in *English* and *Russian* 
* **assetName** is a filename of country's flag that is bundled inside *images* folder of this project
* **cities** is the cities' list of this country
* city **id** is an identifier from http://www.pogodaiklimat.ru/ web resource
* city **name** is a name with two possible variants in *English* and *Russian*
