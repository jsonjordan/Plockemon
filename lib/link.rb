class Link < ActiveRecord::Base
validates_presence_of :url, :title, :created_at, :user_id
validates_uniqueness_of :url, scope: :user_id
validates_uniqueness_of :title, scope: :user_id
belongs_to :user



  def relevent_data
    {"url" => self.url,
    "title" => self.title,
    "description" => self.description ||= ""}
  end

  def relevent_data_with_reco
    friend = User.find(self.recommended_by_id).username
    {"url" => self.url,
    "title" => self.title,
    "description" => self.description ||= "",
    "recommended_by" => friend}
  end




end
