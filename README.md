#Plock

Work with engineers from another discipline to build a polished application for sharing links

As a user, I want to be able to
```
save links that seem interesting

see links that I've saved in the past

recommend links to other users

see links that other users have recommended to me and who recommended them
```
```
Moreover, I'd like for any recommendations that get made to be published to
the #plock_recommendations channel in our Slack team (with the username of both
the recommender and recommendee)
```

I'm okay with using a hardcoded list of users / passwords / Slack usernames as a proof of concept.

Also, if you want to punch up the name / brand, feel free!

#Api

## To add link
####post "/links"

**request**
```
  header: Authorization: "username"
```
```
  body = {url => "www....",
          title => "Funny Cat",
          description => "Cat cant jump from counter."} in json format
```
**response**

200 - OK

400 - Bad Request

401 - Unauthorized (no username)

403 - Forbidden (username isnt in database)

404 - Not Found

500 - Server Issues

## To get links
####get "/links"

**request**
```
  header: Authorization: "username"
```
**response**
```
  body = {username => "username",
          links => [
              {url => "www.... ",
              title => "Funny Cat",
              description => "Cat cant jump from counter."},
              {url => "www....",
              title => "Stupid Dog",
              description => "Dog runs away from kitten."}
                    ]
              } in json format
```
400 - Bad Request

401 - Unauthorized (no username)

403 - Forbidden (username isnt in database)

404 - Not Found

500 - Server Issues

## To post recommendations
####post "/links/recommended"

**request**
```
  header: Authorization: "username"

  body = {url => "www....",
          title => "Funny Cat",
          description => "Cat cant jump from counter.",
          recommended_for => "scrappydoo"}
          in json format
```
**response**

400 - Bad Request

401 - Unauthorized (no username)

403 - Forbidden (username isnt in database)

404 - Not Found

500 - Server Issues

## To get recommendations
####get "/links/recommended"

**request**
```
  header: Authorization: "username"
```
**response**
```
  body = {username => "username",
          links => [
              {url => "www.... ",
              title => "Funny Cat",
              description => "Cat cant jump from counter.",
              recommended_by => "jamesdabbs"},
              {url => "www....",
              title => "Stupid Dog",
              description => "Dog runs away from kitten.",
              recommended_by => "cthulhu"}
                    ]
              } in json format
```
400 - Bad Request

401 - Unauthorized (no username)

403 - Forbidden (username isnt in database)

404 - Not Found

500 - Server Issues

## To delete a link
####delete "/links"

**request**
```
  header: Authorization: "username"

  body = {title => "Funny Cat"}
          in json format
```
**response**
200 - OK

400 - Bad Request

401 - Unauthorized (no username)

403 - Forbidden (username isnt in database)

404 - Not Found (user has no links)

500 - Server Issues
