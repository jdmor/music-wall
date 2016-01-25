get '/' do
  @songs = Song.all
  
  erb :index
end

get '/new' do
  erb :'new/index'
end