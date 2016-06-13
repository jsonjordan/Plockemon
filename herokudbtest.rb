require 'httparty'
require 'pry'

# r = HTTParty.get("https://plockemon.herokuapp.com/links",
#               :headers => {"Authorization" => "travisjohnson"})
#
#
#
# read = JSON.parse(r.body)

p = HTTParty.post("https://plockemon.herokuapp.com/links/recommended",
              :headers => {"Authorization" => "jason.jordan"},
              :body => {"url" => "https://plockemon.herokuapp.com/",
              "title" => "Plockemon",
              "description" => "Gotta link em' all!",
              "recommended_for" => "mariacassino"}.to_json)

#
# q = HTTParty.get("https://plockemon.herokuapp.com/links",
#               :headers => {"Authorization" => "jason.jordan"})
#
#
#
# qread = JSON.parse(q.body)

binding.pry
