require 'pry'
require 'minitest/autorun'
require 'minitest/focus'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'rack/test'
require './app'

class AppTests < Minitest::Test
  include Rack::Test::Methods

  def app
    PlockApp
  end

  def setup
    PlockApp.reset_database
  end

  def make_existing_users
    User.create! username: "mariacassino"
    User.create! username: "jason.jordan"
  end

  def test_users_can_add_links
    make_existing_users
    user = User.first
    header "Authorization", user.username
    assert_equal 0, Link.count

    r = post "/links", description: "New Hotness", title: "Blahblah", url: "www.whocares.com", user_id: user.id

    assert_equal 200, r.status
    assert_equal 1, Link.count
    assert_equal "New Hotness", Link.first.description
  end

  def test_user_can_recommed_to_another_user
    make_existing_users
    user = User.first
    friend = User.last
    header "Authorization", user.username
    assert_equal 0, Link.count

    r = post "links/recommended", description: "New Hotness", title: "Blahblah", url: "www.whocares.com", recommended_by: user.id, user: friend.username

    assert_equal 200, r.status
    assert_equal 1, Link.count
    binding.pry
    assert_equal user.id, Link.first.recommended_by
    assert_equal friend.id, Link.first.user_id

  end

end
