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
    @song = Song.new(name: params[:song_name])
      genre_ids.each do |genre_id|
      genre = Genre.find_by(id: genre_id)
      if genre
        @song.genres << genre
      end
    end
	    redirect to "songs/#{@song.slug}"
  end

end
