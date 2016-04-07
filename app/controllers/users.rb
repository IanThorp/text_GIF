get '/users' do
  erb :'/users/index'
end


get '/users/new' do
    erb :'/users/new'
end

post '/users' do
  p params
  user = User.new(params[:user])
  if user.save
    session[:id] = user.id
    redirect "/"
  else
    @errors = user.errors[:email]
    erb:'users/new'
  end
end

get '/users/:id/edit' do

end
