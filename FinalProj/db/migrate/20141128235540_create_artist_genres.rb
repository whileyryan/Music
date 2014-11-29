class CreateArtistGenres < ActiveRecord::Migration
  def change
    create_table :artist_genres do |t|
      t.belongs_to :artist, :genre

      t.timestamps
    end
  end
end
