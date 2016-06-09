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
    if username
      User.where(username: username).first_or_create!
    else
      halt 401
    end
  end

  get "/links" do

  end

  post "/links" do
    user_id = User.find_by(username: params[:username]).id
    Link.create!(url: params[:url], title: params[:title], description: params[:description], user_id: user_id)
  end

  get "/links/recommended" do

  end

  post "/links/recommended" do
    friend_id = User.find_by(username: params[:user]).id
    Link.create!(url: params[:url], title: params[:title], description: params[:description], user_id: friend_id, recommended_by_id: user.id)
  end

end
