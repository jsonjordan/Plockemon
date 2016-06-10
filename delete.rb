delete "/links" do
  parsed_data = parsing_incoming
    user.links.find_by(title: parsed_data["title"]).delete_all 
  end
end
