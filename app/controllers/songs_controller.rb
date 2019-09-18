class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get "/songs" do
    @songs = Song.all
    erb :"/songs/index"
  end

  post "/songs/?" do
    artist = Artist.find_or_create_by(params[:artist])

    song = Song.create(
      name: params[:song][:name],
      artist_id: artist.id
    )

    if params[:song][:genres]
      params[:song][:genres].each do |genre_id|
        song.genres << Genre.find(genre_id)
      end
    end

    flash[:message] = "Successfully created song."
    redirect "/songs/#{song.slug}"
  end

  get "/songs/new" do
    @song = Song.new
    @artists = Artist.order(:name)
    @genres = Genre.order(:name)
    erb :"/songs/new"
  end

  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = @song.genres
    erb :"/songs/show"
  end

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    @artists = Artist.order(:name)
    @genres = Genre.order(:name)
    erb :"/songs/edit"
  end

  patch "/songs/:slug" do
    artist = Artist.find_or_create_by(params[:artist])
    song = Song.find_by_slug(params[:slug])
    song.update(
      name: params[:song][:name],
      artist_id: artist.id
    )

    song.genres.clear
    if params[:song][:genres]
      params[:song][:genres].each do |genre_id|
        song.genres << Genre.find(genre_id)
      end
    end

    flash[:message] = "Successfully updated song."
    redirect "/songs/#{song.slug}"
  end

end