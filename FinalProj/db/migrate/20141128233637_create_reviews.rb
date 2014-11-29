class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user_id, :artist_id
      t.string :venue, :content
      t.integer :ticket_price
      t.integer :music_rating, :atmosphere_rating, :overall_rating, :composite_rating
      t.string :event_date
      t.integer :votes
      t.boolean :repeat_experience

      t.timestamps
    end
  end
end
