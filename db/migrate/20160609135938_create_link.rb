class CreateLink < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.text :description
      t.integer :recommended_by_id
      t.datetime :created_at, default: Time.now
      t.integer :user_id
    end
  end
end
