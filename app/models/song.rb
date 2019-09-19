class Song < ActiveRecord::Base
    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres

    def slug
        self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(slug)
        self.all.find{|song| song.slug == slug}
    end

    def genre_names
        self.genres.map(&:name)
    end

    def genre_by_artist(artist)
        self.genres.select{|genre| genre.artists.include? artist}
    end

end