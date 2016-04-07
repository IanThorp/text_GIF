helpers do
  def logged_in?
      session[:id] != nil
  end

  def current_user
    @current_user ||= User.find(session[:id])
  end

  def logout!
    session.clear
  end

  def login(user)
    session[:id] = user.id
  end

end
