get '/' do
  @songs = Song.all

  erb :index
end

get '/new' do
  erb :'new/index'
end

get '/login' do
  erb :'login/index'
end

get '/create-account' do
  erb :'create-account/index'
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

post '/login' do
  if params[:email].empty? || params[:password].empty?
    erb :'login/index'
  else
    user = User.find_by(email: params[:email], password: params[:password])
    user ? redirect('/') : erb(:'login/index')
  end
end

post '/create-account' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )

  if @user.save
    redirect '/'
  else
    erb :'create-account/index'
  end
end