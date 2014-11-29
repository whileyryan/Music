class User < ActiveRecord::Base
  has_many :reviews
  has_many :artist_users
  has_many :artists_following, through: :artist_users, :source => :artist
  has_many :artists_reviewed, through: :reviews, :source => :artist
end
