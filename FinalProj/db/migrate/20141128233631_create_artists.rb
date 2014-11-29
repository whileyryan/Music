class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :mbid, :name
      t.boolean :review_flag
      t.integer :music_rating, :atmosphere_rating, :overall_rating, :composite_rating
      t.timestamps
    end
  end
end
