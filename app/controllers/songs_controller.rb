

require 'rack-flash'

class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash

    #index
    get "/songs/?" do 
        @songs = Song.all
        erb :"songs/index"
    end

    #new
    get "/songs/new" do 
        @song = Song.new
        @artists = Artist.all
        @genres = Genre.all
        erb :"songs/new"
    end

    #create {"song"=>{"name"=>"test", "artist_id"=>"6", "genre_ids"=>["1", "5"]}, "artist"=>{"name"=>""}, "genre"=>{"name"=>"Soft Rock"}}
    post "/songs/?" do

        @song = Song.find_or_create_by(name: params["song"]["name"], artist_id: params["song"]["artist_id"])

        if !params["artist"]["name"].empty?
            @artist = Artist.find_or_create_by(name: params["artist"]["name"])
            @song.artist = @artist
            @song.save
        end

        if !params["genre"]["name"].empty?
            @genre = Genre.find_or_create_by(name: params["genre"]["name"])
            @song.genres << @genre
            @song.save
        end

        params["song"]["genre_ids"].each do |genre_id|
            @song.genres << Genre.find(genre_id)
            @song.save
        end
        
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    
    end 

    #show
    get "/songs/:slug" do
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/show"
    end

    #edit
    get "/songs/:slug/edit" do
        @song = Song.new
        @artists = Artist.all
        @genres = Genre.all
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/edit"
    end

    #update {"song"=>{"name"=>"That One with the Guitar", "artist_id"=>"1", "genre_ids"=>["1"]}, "artist"=>{"name"=>"Some Nobody"}, "genre"=>{"name"=>""}, "_method"=>"patch", "slug"=>"that-one-with-the-guitar"}
    patch "/songs/:slug" do
        @song = Song.find_by_slug(params[:slug])
        @song.name = params["song"]["name"]
        @song.artist.id = params["song"]["artist_id"]

        if !params["artist"]["name"].empty?
            @artist = Artist.find_or_create_by(name: params["artist"]["name"])
            @song.artist = @artist
            @song.save
        end

        if !params["genre"]["name"].empty?
            @genre = Genre.find_or_create_by(name: params["genre"]["name"])
            @song.genres << @genre
            @song.save
        end

        params["song"]["genre_ids"].each do |genre_id|
            @song.genres << Genre.find(genre_id)
            @song.save
        end

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end



end
