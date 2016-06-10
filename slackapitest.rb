require 'pry'
require 'httparty'
require 'json'

text = "@mariacassino recommended https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet for @jason.jordan!"

r = HTTParty.post("https://slack.com/api/chat.postMessage",
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
#@mariacassino recommended for @jason.jordan:
