require "./db/setup"
require "./lib/all"

[User, Link].each { |klass| klass.delete_all }

maria = User.create! username: "mariacassino"
jason = User.create! username: "jason.jordan"
travis = User.create! username: "travisjohnson"
nastassia = User.create! username: "nntroyer"
daniel = User.create! username: "daniel_buompane"
marybeth = User.create! username: "marybethclark"
nicole = User.create! username: "nicole.palumbo"
dana = User.create! username: "dana"


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

#Daniel
Link.create!(user_id: daniel.id, url: "https://www.youtube.com/watch?v=DLOth-BuCNY", title: "Dark Side Of The Moon video", description: "from youtube")
Link.create!(user_id: daniel.id, url: "https://www.destroyallsoftware.com/talks/wat", title: "Wat?", description: "Gary Bernhardt's wat video")
Link.create!(user_id: daniel.id, url: "http://rubykaigi.org/2015/presentations/prodis", title:"Worst Ruby Code", description: "A collection of badly written ruby code")
Link.create!(user_id: jason.id, url: "http://guides.rubyonrails.org/", title: "RailsGuides", description: "Some of the best rails info out there",
recommended_by_id: daniel.id)

#MaryBeth
Link.create!(user_id: marybeth.id, url: "http://www.puttingmetogether.com/2012/03/building-remixable-wardrobe-part-4.html", title: "Putting Me Together", description: "Build a remixable wardrobe")
Link.create!(user_id: marybeth.id, url: "http://www.design-seeds.com/", title: "Design Seeds", description: "No idea")
Link.create!(user_id: marybeth.id, url: "http://www.thegreenhead.com/", title:"The Green Head", description: "About the Hulk maybe?")
Link.create!(user_id: jason.id, url: "https://www.amazon.com/Ruby-Rails-Dummies-Barry-Burd/dp/0470081201", title: "Rails for Dummies", description: "Really good basic info!",
recommended_by_id: marybeth.id)

#Nicole
Link.create!(user_id: nicole.id, url: "https://www.amazon.com", title: "Amazon", description: "awesome shopping")
Link.create!(user_id: nicole.id, url: "https://www.twitter.com", title: "Twitter", description: "lots o' tweetin yall")
Link.create!(user_id: nicole.id, url: "http://www.pinterest.com", title:"Pinterest", description: "Boards full of awesome")
Link.create!(user_id: dana.id, url: "http://www.thisiswhyimbroke.com/", title: "This is why im broke", description: "Some of the greatest items ever made for purchase!",
recommended_by_id: nicole.id)

#Dana
Link.create!(user_id: dana.id, url: "hhttps://trello.com/", title: "Trello", description: "trello")
Link.create!(user_id: dana.id, url: "https://www.twitter.com", title: "Twitter", description: "lots o' tweetin yall")
Link.create!(user_id: dana.id, url: "https://slack.com/", title:"Pinterest", description: "Boards full of awesome")
Link.create!(user_id: nicole.id, url: "https://www.etsy.com/", title: "Etsy", description: "Handmade stuff",
recommended_by_id: dana.id)
