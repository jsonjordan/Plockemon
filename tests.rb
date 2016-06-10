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

  def user
    User.where(username: "mariacassino").first_or_create!
  end

  def friend
    User.where(username: "jason.jordan").first_or_create!
  end

  # def make_existing_users
  #   User.create! username: "mariacassino"
  #   User.create! username: "jason.jordan"
  #   User.create! username: "travisjohnson"
  #   User.create! username: "nntroyer"
  # end

  def trial_body
    {"url" => "www.whocares.com",
    "title" => "Blahblah",
    "description" => "New Hotness"}.to_json
  end

  def trial_body2
    {"url" => "www.blah.com",
    "title" => "Beep",
    "description" => "Boop"}.to_json
  end

  def trial_body_recom
    {"url" => "www.whocares.com",
    "title" => "Blahblah",
    "description" => "New Hotness",
    "recommended_for" => friend.username}.to_json
  end

  def trial_body_recom2
    {"url" => "www.whateva.com",
    "title" => "Aardwolf",
    "description" => "Not a panda",
    "recommended_for" => friend.username}.to_json
  end

  def trial_body_missing
    {"title" => "Blahblah",
    "description" => "New Hotness"}.to_json
  end

  def trial_body_missing_recom
    {"url" => "www.whocares.com",
    "description" => "New Hotness",
    "recommended_for" => friend.username}.to_json
  end

  def test_users_can_add_links
    header "Authorization", user.username

    assert_equal 0, Link.count

    r = post "/links", body = trial_body

    assert_equal 200, r.status
    assert_equal 1, Link.count
    assert_equal "New Hotness", Link.first.description
  end

  def test_user_can_recommend_to_another_user
    header "Authorization", user.username
    assert_equal 0, Link.count

    r = post "links/recommended", body = trial_body_recom

    assert_equal 200, r.status
    assert_equal 1, Link.count
    assert_equal user.id, Link.first.recommended_by_id
    assert_equal friend.id, Link.first.user_id

  end

  def test_no_username_will_error
    r = post "/links", body = trial_body

    assert_equal 401, r.status
  end

  def test_wrong_username_will_error
    header "Authorization", "johnnybgood"


    r = post "/links", body = trial_body

    assert_equal 403, r.status
  end

  def test_missing_params_will_error
    header "Authorization", user.username

    r = post "/links", body = trial_body_missing
    q = post "links/recommended", body = trial_body_missing_recom

    assert_equal 400, q.status
    assert_equal 400, r.status
  end

  def test_user_can_get_list_of_links
    header "Authorization", user.username
    q = post "/links", body = trial_body
    t = post "/links", body = trial_body2

    r = get "/links"

    assert_equal 200, r.status
    body = JSON.parse r.body
    assert_equal 2, body.count
  end

  def test_user_can_get_list_of_recoms
    header "Authorization", user.username
    q = post "/links/recommended", body = trial_body_recom
    t = post "/links/recommended", body = trial_body_recom2

    header "Authorization", friend.username

    r = get "/links/recommended"

    assert_equal 200, r.status
    body = JSON.parse r.body
    assert_equal 2, body.count
  end

  def test_user_with_no_links_will_get_error
    header "Authorization", friend.username

    r = get "/links"

    assert_equal 404, r.status
  end

  def test_user_with_no_recommended_will_get_error
    header "Authorization", friend.username

    r = get "/links/recommended"

    assert_equal 404, r.status
  end
end
