class GenresController < ApplicationController

    #index
    get "/genres/?" do 
        @genres = Genre.all
        erb :"genres/index"
    end

    #new
    get "/genres/new" do 
        @genre = Genre.new
        erb :"genres/new"
    end

    #create 


    #show
    get "/genres/:slug" do
        @genre = Genre.find_by_slug(params[:slug])
        erb :"genres/show"
    end

end
