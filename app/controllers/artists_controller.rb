class ArtistsController < ApplicationController

      #index
      get "/artists/?" do 
        @artists = Artist.all
        erb :"artists/index"
    end

    #new
    get "/artists/new" do 
        @artist = Artist.new
        erb :"artists/new"
    end

    #create 

    #show
    get "/artists/:slug" do
        @artist = Artist.find_by_slug(params[:slug])
        erb :"artists/show"
    end

end
