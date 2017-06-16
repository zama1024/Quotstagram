require 'bcrypt'
require 'byebug'
class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: {minimum: 6}, allow_nil: true

  after_initialize :ensure_session_token

  def self.find_by_credentials(credentials)
    user = User.find_by(username: credentials[:username])
    return user if user && BCrypt::Password.new(user.password_digest).is_password?(credentials[:password])
    nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    byebug
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
