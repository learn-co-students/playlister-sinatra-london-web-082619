class ArtistsController < ApplicationController

    #READ - index
    get "/artists" do
        @artists = Artist.all
        erb :"/artists/index"
    end

    #READ - show
    get '/artists/:slug' do 
        @artist = Artist.find_by_slug(params[:slug])
        @songs = @artist.songs
        erb :'artists/show'
      end
end
