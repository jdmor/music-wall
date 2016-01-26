helpers do
  def poster_email(id)
    User.find_by(id: id).email
  end
end

get '/' do
  @songs = Song.select('songs.id, songs.title, songs.author, songs.url, upvotes.user_id, COUNT(upvotes.song_id) AS upvote_count')
  @songs = @songs.joins('LEFT OUTER JOIN upvotes ON upvotes.song_id = songs.id')
  @songs = @songs.group('songs.id').order('upvote_count DESC')
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
    url: params[:url],
    users_id: session['user_id']
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
  end

  if user
    session['user_id'] = user.id
    redirect '/'
  else
    erb :'login/index'
  end

end

post '/create-account' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )

  if @user.save
    session['user_id'] = @user.id
    redirect '/'
  else
    erb :'create-account/index'
  end
end

get '/signout' do
  session['user_id'] = nil
  redirect '/'
end

post '/upvote' do
  upvote = Upvote.new song_id: params[:song_id], user_id: session['user_id']
  if upvote.save
    redirect '/'
  else
    redirect '/login' 
  end
end