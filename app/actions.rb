get '/' do
  erb :index
end

get '/new' do
  erb :'new/index'
end