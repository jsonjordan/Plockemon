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
      halt 401
    elsif username == User.where(username: username).first.username
      User.where(username: username).first
    else
      # raise "User not found"
      halt 401
    end

  end

  get "/links" do

  end

  post "/links" do
    begin
      Link.create!(url: params[:url], title: params[:title], description: params[:description], user_id: user.id)
    rescue
      400
    end
  end

  get "/links/recommended" do

  end

  post "/links/recommended" do
    begin
      friend_id = User.find_by(username: params[:user]).id
      Link.create!(url: params[:url], title: params[:title], description: params[:description], user_id: friend_id, recommended_by_id: user.id)
    rescue
      400
    end
  end

end
