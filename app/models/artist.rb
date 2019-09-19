class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs

    def slug
        self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(slug)
        self.all.find{|artist| artist.slug == slug}
    end

    def songs_by_genre(genre)
        self.songs.select{|song| song.genres.include? genre}
    end
    
end