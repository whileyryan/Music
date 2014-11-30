class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :venue
      t.string :artist
      t.string :date
      t.string :url
      t.timestamps null: false
    end
  end
end
