require 'byebug'
class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      byebug
    else
      byebug
    end
  end

  def user_params
    byebug
    params.require(:user).permit(:username,:password)
  end
end
