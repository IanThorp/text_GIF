get '/' do
  redirect "/restaurants"
end

post '/recieve_sms' do

  content_type 'text/xml'

  response = Twilio::TwiML::Response.new do |r|
    r.Message do |message|
      message.Body "This is an update"
      message.Media "https://media.giphy.com/media/ykJRqKWc0cY5W/giphy.gif"
    end
  end

  response.to_xml
end

# get '/cat_fact' do
#   api_result = RestClient.get 'http://www.catfact.info//api/v1/facts.json'
#   jhash = JSON.parse(api_result)
#   p jhash["facts"][rand(1..16)]["details"]
#   redirect '/'
# end

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
  @api_result = RestClient.get 'http://www.catfact.info//api/v1/facts.json'
  @jhash = JSON.parse(@api_result)
  @result = @jhash["facts"][rand(1..16)]["details"]

  @number = "+1#{params[:phone]}"
# set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new ENV['TWILLIO_SID'], ENV['TWILLIO_AUTH']
  if params[:body] == nil
    @client.account.messages.create({
      :from => '+18315741012',
      :to => @number,
      :body => @result,
    })
  else
    @client.account.messages.create({
      :from => '+18315741012',
      :to => @number,
      :body => params[:body],
    })
  end
  @message = "Message sent successfully?"
  @errors
  erb :'index'
end
