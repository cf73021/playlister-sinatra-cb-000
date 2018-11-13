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
      @song = Song.new(name: params[:song_name])
      if artist_name != ""
        @song.artist = Artist.find_or_create_by(name: artist_name)
      end
    else
      @error_message = "You must enter a song name!"
      @genres = Genre.all
      erb :'/songs/new'

end
