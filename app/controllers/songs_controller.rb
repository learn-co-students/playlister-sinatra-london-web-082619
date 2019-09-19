# require 'rack-flash'

class SongsController < ApplicationController
# use Rack::Flash

    get '/songs/?' do
        @songs = Song.all.sort_by(&:name)
        erb :'/songs/index'
    end

    get '/songs/new/?' do
        @song = Song.new
        @genres = Genre.all.sort_by(&:name)
        @artists = Artist.all.sort_by(&:name)
        erb :'/songs/new'
    end

    get '/songs/:id/?' do
        id = params[:id]
        @song = Song.find_by_slug(id)
        @genres = @song.genres
        @artist = @song.artist
        erb :'/songs/show'
    end

    get '/songs/:id/edit' do
        id = params[:id]
        @song = Song.find_by_slug(id)
        @genres = Genre.all.sort_by(&:name)
        @artists = Artist.all.sort_by(&:name)
        erb :'/songs/edit'
    end

    post '/songs/?' do
        @song = Song.new(name: params[:song][:name])
        
        if  params[:song][:genre_ids]
            params[:song][:genre_ids].each do |id|
            @song.genres << Genre.find(id)
            end
        end

        if !params[:genre][:name].empty?
            genre = Genre.find_by(name: params[:genre][:name])
            if genre
                @song.genres << genre
            else
                @song.genres << Genre.create(name: params[:genre][:name])
            end
        end

        if !params[:artist][:name].empty?
            artist = Artist.find_by(name: params[:artist][:name])
            if artist
                @song.artist = artist
            else
                @song.artist = Artist.create(name: params[:artist][:name])
            end
        else
            @song.artist = Artist.find(params[:song][:artist_id])
        end

        @song.save

        # flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"


    end

    patch '/songs/:id' do
        id = params[:id]
        @song = Song.find_by_slug(id)
        
        if  params[:song][:genre_ids]
            @song.genres.clear
            params[:song][:genre_ids].each do |id|
            @song.genres << Genre.find(id)
            end
        end

        if !params[:genre][:name].empty?
            genre = Genre.find_by(name: params[:genre][:name])
            if genre
                @song.genres << genre
            else
                @song.genres << Genre.create(name: params[:genre][:name])
            end
        end

        if !params[:artist][:name].empty?
            artist = Artist.find_by(name: params[:artist][:name])
            if artist
                @song.artist = artist
            else
                @song.artist = Artist.create(name: params[:artist][:name])
            end
        else
            @song.artist = Artist.find(params[:song][:artist_id])
        end

        @song.save
        redirect "/songs/#{@song.slug}"


    end

    

end
