require "pry"
require "sinatra/base"
require "sinatra/json"

require "./db/setup"
require "./lib/all"

class PlockApp < Sinatra::Base
  set :logging, true
  set :show_exceptions, false

  error do |e|
    raise e
  end

  def self.reset_database
    [User, Link].each { |klass| klass.delete_all }
  end

  def user
    username = request.env["HTTP_AUTHORIZATION"]
    if !username
      # raise "No username provided"
      halt 401, "Username not provided"
    elsif User.where(username: username).first
      User.where(username: username).first
    else
      # raise "User not found"
      halt 403, "No user by that username"
    end

  end

  def parsing_incoming
    incoming_data = request.body.read
    JSON.parse incoming_data
  end

  get "/links" do
    link_list = user.links.where(recommended_by_id: nil).map {|l| l.relevent_data}
    body = {"username" => user.username,
            "links" => link_list
                }

    json body
  end

  post "/links" do
    parsed_data = parsing_incoming
    begin
      Link.create!(url: parsed_data["url"], title: parsed_data["title"], description: parsed_data["description"], user_id: user.id)
    rescue
      400
    end
  end

  get "/links/recommended" do
    # link_list = Link.where(user_id: user.id).select{|k| k.recommended_by_id.present? }.map {|l| l.relevent_data_with_reco}
    link_list = user.links.where.not(recommended_by_id: nil).map {|l| l.relevent_data_with_reco}
    body = {"username" => user.username,
            "links" => link_list
                }

    json body
  end

  post "/links/recommended" do
    parsed_data = parsing_incoming
    begin
      friend_id = User.find_by(username: parsed_data["recommended_for"]).id
    rescue
      halt 400, "No such user exists"
    end
    begin
      Link.create!(url: parsed_data["url"], title: parsed_data["title"], description: parsed_data["description"], user_id: friend_id, recommended_by_id: user.id)
    rescue
      halt 400, "Not all information provided"
    end
  end

end
