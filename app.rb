require "pry"
require "sinatra/base"
require "sinatra/json"

require 'httparty'
require 'json'
require 'github/markup'

require "./db/setup"
require "./lib/all"
require "rack/cors"


class PlockApp < Sinatra::Base
  set :logging, true
  set :show_exceptions, false

  # use Rack::Cors do
  #   allow do
  #     origins "*"
  #     resource "*", headers: :any, methods: :any
  #   end
  # end

  error do |e|
    raise e
  end

  def self.reset_database
    [User, Link].each { |klass| klass.delete_all }
  end

  def user
    username = request.env["HTTP_AUTHORIZATION"]
    if !username
      halt 401, "Username not provided"
    elsif User.find_by(username: username)
      User.find_by(username: username)
    else
      halt 403, "No user by that username"
    end
  end

  def parsing_incoming
    incoming_data = request.body.read
    begin
      JSON.parse incoming_data
    rescue
      halt 400, "Request not JSON formatted"
    end
  end

  get "/" do
    @html = GitHub::Markup.render('README.md', File.read("README.md"))
    erb :readme
  end

  get "/links" do
    if user.links.where(recommended_by_id: nil).count > 0
      link_list = user.links.where(recommended_by_id: nil).map {|l| l.relevent_data}
      body = {"username" => user.username,
              "links" => link_list
                  }


      json body
    else
      halt 404, "User has no links"
    end
  end

  post "/links" do
    parsed_data = parsing_incoming
    begin
      Link.create!(url: parsed_data["url"], title: parsed_data["title"], description: parsed_data["description"], user_id: user.id)
    rescue
      halt 400, "Not all information provided"
    end
  end

  get "/links/recommended" do
    if user.links.where.not(recommended_by_id: nil).count > 0
      link_list = user.links.where.not(recommended_by_id: nil).map {|l| l.relevent_data_with_reco}
      body = {"username" => user.username,
              "links" => link_list
                  }

      json body
    else
      halt 404, "User has no recommended links"
    end
  end

  post "/links/recommended" do
    parsed_data = parsing_incoming
    begin
      friend = User.find_by(username: parsed_data["recommended_for"])
    rescue
      halt 400, "No such user exists"
    end
    begin
      Link.create!(url: parsed_data["url"], title: parsed_data["title"], description: parsed_data["description"], user_id: friend.id, recommended_by_id: user.id)
    rescue
      halt 400, "Not all information provided"
    end

    text = "@#{user.username} recommended #{parsed_data["url"]} for @#{friend.username}!"

    HTTParty.post("https://slack.com/api/chat.postMessage",
                  query: {token: SLACK_TOKEN,
                          channel: "C1FJJ2W1F",
                          text: text,
                          unfurl_links: true,
                          unfurl_media: true,
                          link_names: 1,
                          username: "Plokebot",
                          as_user: true,
                          icon_url: "http://orig14.deviantart.net/bfb7/f/2014/221/2/4/pokeball_cutie_mark_by_cottenheart-d7ufe4x.png"
                          }
                          )
  end
end

PlockApp.run!
