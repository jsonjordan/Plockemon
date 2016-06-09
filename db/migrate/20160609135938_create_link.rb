class CreateLink < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.text :description
      t.string :recommended_by
      t.datetime :created_at
      t.integer :user_id
    end 
  end
end
