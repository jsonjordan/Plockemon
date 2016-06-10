require "./db/setup"
require "./lib/all"

[User, Link].each { |klass| klass.delete_all }

maria = User.create! username: "mariacassino"
jason = User.create! username: "jason.jordan"
travis = User.create! username: "travisjohnson"
nastassia = User.create! username: "nntroyer"



#Maria [user_id = 13]
Link.create!(user_id: maria.id, url: "http://guides.rubyonrails.org/", title: "Rails Guides", description: "Rails guide")
Link.create!(user_id: maria.id, url: "http://www.google.com", title: "Google!", description: "search for stuff")
Link.create!(user_id: maria.id, url: "http://www.wellsfargo.com", title:"Wells Fargo", description: "A Bank")
Link.create!(user_id: jason.id, url: "http://www.facebook.com", title: "Facebook", description: "I spend way too much time on here",
recommended_by_id: maria.id)

#Jason [user_id = 14]
Link.create!(user_id: jason.id, url: "http://www.cracked.com", title: "Cracked", description: "Stupid list humor")
Link.create!(user_id: jason.id, url: "http://www.homestarrunner.com", title: "Homestar Runner", description: "Stupid cartoon humor")
Link.create!(user_id: jason.id, url: "http://www.physics.org", title: "Physics.org", description: "Smart physics stuff")
Link.create!(user_id: maria.id, url: "http://www.twitter.com", title: "Twitter", description: "I read more of this than books",
recommended_by_id: jason.id)

#Travis [user_id = 15]
Link.create!(user_id: travis.id, url: "http://www.reddit", title: "Reddit", description: "so many subs")
Link.create!(user_id: travis.id, url: "http://www.adultswim.com", title: "Adult Swim", description: "finally with less anime")
Link.create!(user_id: travis.id, url: "http://www.sputnikmusic.com", title: "musicz", description: "muusic")
Link.create!(user_id: nastassia.id, url: "http://www.cracked.com", title: "Cracked", description: "Stupid list humor",
recommended_by_id: travis.id)

#Nastassia [user_id = 16]
Link.create!(user_id: nastassia.id, url: "http://soundcloud.com", title: "musicz", description: "clouds made of sound")
Link.create!(user_id: nastassia.id, url: "http://www.thedieline.com", title: "Die", description: "maybe about dying?")
Link.create!(user_id: nastassia.id, url: "http://mashable.com", title: "Mashable", description: "tech things")
Link.create!(user_id: travis.id, url: "http://www.yahoo.com", title: "Yahoo", description: "is this still around??",
recommended_by_id: nastassia.id)
