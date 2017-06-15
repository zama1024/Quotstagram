require 'bcrypt'
class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true

  validates :password, length: {minimum: 6}, allow_nil: true

  def self.find_by_credentials(credentials)
    user = User.find_by(username: credentials[:username])
    user && user.is_password?(credentials[:password]) ? user : nil
  end
