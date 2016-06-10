require 'pry'
require 'httparty'
require 'json'
require './token'


r = HTTParty.post("https://slack.com/api/chat.postMessage", query: {token: Token, channel: "C1FJJ2W1F", text: "Icon test", username: "Plokebot", as_user: false, icon_url: "http://orig14.deviantart.net/bfb7/f/2014/221/2/4/pokeball_cutie_mark_by_cottenheart-d7ufe4x.png"})


binding.pry
