class User < ActiveRecord::Base
  include BCrypt

  has_many :reviews
  has_many :restaurants
  validates :email, uniqueness: {message: "Sorry, but that email has already been taken."}


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.password == password
  end
end
