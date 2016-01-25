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
  
  if @song.save
    redirect '/'
  else
    erb :'new/index'
  end
end

get '/new' do
  erb :'new/index'
end