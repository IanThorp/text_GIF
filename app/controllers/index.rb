get '/' do
  redirect "/restaurants"
end


get '/logout' do
  logout!
  redirect '/restaurants'
end

get '/login' do
    erb :'/login'
end

post '/login' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:id] = user.id
    redirect '/'
  else
    @errors = ["Sorry, the credentials provided do not match"]
    erb :'/login'
  end
end

post '/send' do

  number = "+1#{params[:phone]}"
# set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new ENV['TWILLIO_SID'], ENV['TWILLIO_AUTH']

  @client.account.messages.create({
    :from => '+18315741012',
    :to => number,
    :body => params[:body],
  })
  @message = "Message sent successfully?"
  @errors
  erb :'index'
end
