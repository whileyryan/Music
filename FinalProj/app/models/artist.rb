class Artist < ActiveRecord::Base
  has_many :artist_users
  has_many :followers, :through => :artist_users, source: :user
  has_many :reviewers, :through => :reviews, source: :user
  has_many :reviews
  has_many :artist_genres
  has_many :genres, :through => :artist_genres
end
