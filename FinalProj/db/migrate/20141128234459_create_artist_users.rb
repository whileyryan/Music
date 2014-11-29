class CreateArtistUsers < ActiveRecord::Migration
  def change
    create_table :artist_users do |t|
      ####following/follower table
      t.belongs_to :user
      t.belongs_to :artist
      t.timestamps
    end
  end
end
