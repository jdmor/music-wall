helpers do

  def current_user
    session['user_id']
  end

  def poster_email(id)
    User.find_by(id: id).email
  end

  def already_upvoted?(song_id, user_id)
    Upvote.find_by song_id: song_id, user: user_id
  end

end

get '/' do
  @songs = Song.select('songs.id, songs.title, songs.author, songs.url, songs.user_id, COUNT(upvotes.song_id) AS upvote_count')
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
    user_id: session['user_id']
  )
  
  if @song.save
    redirect '/'
  else
    erb :'new/index'
  end
end

post '/login' do
  user = User.find { |u| u.email == params[:email] }

  if user && user.password == params[:password]
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