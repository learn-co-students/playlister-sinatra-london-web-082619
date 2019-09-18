class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  require_relative 'concerns/slugifiable'

  include Slug
  extend FindBySlug

  def has_genre?(genre)
    self.genres.include?(genre)
  end

  def artist_name
    self.artist.name if self.artist
  end
end