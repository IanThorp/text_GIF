post '/restaurants/:id/reviews' do
  rating = Review.new(params[:review])
  if rating.save
    @restaurant = Restaurant.find(params[:id])
    @made_review = true
  end
  erb :"/restaurants/show"
end
