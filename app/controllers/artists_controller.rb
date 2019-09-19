class ArtistsController < ApplicationController

    get '/artists/?' do
        @artists = Artist.all.sort_by(&:name)
        erb :'artists/index'
    end

    get '/artists/:id/?' do
        id = params[:id]
        unless id.to_i == 0
            @artist = Artist.find(id)
        else
            @artist = Artist.find_by_slug(id)
        end
        @songs = @artist.songs
        @genres = @artist.genres
        erb :'artists/show'
    end

end
