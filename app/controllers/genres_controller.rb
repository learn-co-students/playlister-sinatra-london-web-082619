class GenresController < ApplicationController

    get '/genres/?' do
        @genres = Genre.all.sort_by(&:name)
        erb :'genres/index'
    end

    get '/genres/:id/?' do
        id = params[:id]
        unless id.to_i == 0
            @genre = Genre.find(id)
        else
            @genre = Genre.find_by_slug(id)
        end
        @artists = @genre.artists
        erb :'genres/show'
    end

end
