class Api::V1::UsersController < ApplicationController
  def create
    @user = User.create user_params
    render json: @user
  end

  def logged_in
    find_user params
    if @user and @user.logged_in
      render json: @user
    else
      render json: {logged_in: false}, status: 401
    end
  end

  def log_in
    find_user params
    if @user
      @user.update_attributes(logged_in: true)
    end
  end

  def log_out
    find_user params
    if @user
      @user.update_attributes(logged_in: false)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password_hash, :zipcode)
  end
end
