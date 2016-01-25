get '/' do
  @songs = Song.all

  erb :index
end

post '/' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
  )
  @song.save!

  halt 201
end

get '/new' do
  erb :'new/index'
end