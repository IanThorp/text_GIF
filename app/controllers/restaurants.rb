get '/restaurants' do
  @restaurants = Restaurant.all
  erb :'index'
end



get '/restaurants/new' do
    erb :'/restaurants/new'
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  erb :'/restaurants/show'
end

post '/restaurants' do
  restaurant = Restaurant.new(params[:restaurant])
  if restaurant.save
    redirect '/restaurants'
  end
end

get '/restaurants/:id/edit' do
  erb :"/restaurants/edit"
end

put '/restaurants/:id' do
  restaurant = Restaurant.find(params[:id])
  restaurant.update(params[:restaurant])
  redirect '/restaurants'
end

delete '/restaurants/:id' do
  restaurant = Restaurant.find(params[:id])
  restaurant.destroy
  redirect '/restaurants'
end
