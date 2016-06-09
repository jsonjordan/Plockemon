class Link < ActiveRecord::Base
validates_presence_of :url, :title, :created_at, :user_id
validates_uniqueness_of :url, scope: :user_id
belongs_to :user









end
