#Plock

Work with engineers from another discipline to build a polished application for sharing links

As a user, I want to be able to

save links that seem interesting
see links that I've saved in the past
recommend links to other users
see links that other users have recommended to me and who recommended them
moreover, I'd like for any recommendations that get made to be published to the #plock_recommendations channel in our Slack team (with the username of both the recommender and recommendee)

I'm okay with using a hardcoded list of users / passwords / Slack usernames as a proof of concept.

Also, if you want to punch up the name / brand, feel free!

#Api

## To add link
  post "/links"
  -request
  header: Authorization: "username"
  body = {url => "www....",
          title => "Funny Cat",
          description => "Cat cant jump from counter."} in json format

  -response
  200 - OK
  400 - Bad Request
  401 - Unauthorized (no username likely cause)
  404 - Not Found
  500 - Server Issues
## To get links
  get "/links"
  -request
  header: Authorization: "username"

  -response
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

  400 - Bad Request
  401 - Unauthorized (no username likely cause)
  404 - Not Found
  500 - Server Issues

## To post recommendations
  post "/links/recommended"
  -request
  header: Authorization: "username"
  body = {url => "www....",
          title => "Funny Cat",
          description => "Cat cant jump from counter.",
          reco_user => 145}
          in json format

  -response
  200 - OK
  400 - Bad Request
  401 - Unauthorized (no username likely cause)
  404 - Not Found
  500 - Server Issues

## To get recommendations
  get "/links/recommended"
  -request
  header: Authorization: "username"

  -response
  body = {username => "username",
          links => [
              {url => "www.... ",
              title => "Funny Cat",
              description => "Cat cant jump from counter.",
              reco_user => "jamesdabbs"},

              {url => "www....",
              title => "Stupid Dog",
              description => "Dog runs away from kitten.",
              reco_user => "scoobydoo"}
                    ]
              } in json format

  400 - Bad Request
  401 - Unauthorized (no username likely cause)
  404 - Not Found
  500 - Server Issues


### File Rundown

```
.
├── Gemfile             # Details which gems are required by the project
├── README.md           # This file
├── Rakefile            # Defines `rake generate:migration` and `db:migrate`
├── config
│   └── database.yml    # Defines the database config (e.g. name of file)
├── console.rb          # `ruby console.rb` starts `pry` with models loaded
├── db
│   ├── dev.sqlite3     # Default location of the database file
│   ├── migrate         # Folder containing generated migrations
│   └── setup.rb        # `require`ing this file sets up the db connection
└── lib                 # Your ruby code (models, etc.) should go here
    └── all.rb          # Require this file to auto-require _all_ `.rb` files in `lib`
```
