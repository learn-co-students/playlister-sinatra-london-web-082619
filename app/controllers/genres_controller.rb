class GenresController < ApplicationController

  #READ - index
  get "/genres" do
      @genres = Genre.all
      erb :"/genres/index"
  end

  #READ - show
  get "/genres/:slug" do
    @genre = Genre.find_by_slug(params[:slug])
    @artists = @genre.artists
    erb :"/genres/show"
  end
end