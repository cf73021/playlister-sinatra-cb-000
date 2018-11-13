class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    song_name = params["song"]["name"]
    artist_name = params["artist"]["name"]
    genre_ids = params["genres"] || []
     if song_name
      @song = Song.new(name: song_name)
      if artist_name != ""
        @song.artist = Artist.find_or_create_by(name: artist_name)
      end
    else
      @error_message = "You must enter a song name!"
      @genres = Genre.all
      erb :new
    end
     genre_ids.each do |genre_id|
      genre = Genre.find_by(id: genre_id)
      if genre
        @song.genres << genre
      end
    end
     @song.save
     flash[:notice] = "Successfully created song."
     redirect to "/songs/:slug"

  end
   patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    song_name = params["song"]["name"]
    artist_name = params["artist"]["name"]
     if song_name
      @song.name = song_name
      artist = Artist.find_or_create_by(name: params["artist"]["name"])
      if artist
        @song.artist = artist
      end
       @song.genres = []
      params["genres"].each do |genre_id|
        @song.genres << Genre.find(genre_id)
      end
    end
     @song.save
    redirect to :"/songs/#{@song.slug}"
  end

end
