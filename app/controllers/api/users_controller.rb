class Api::UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
      session[:user_id] = @user.id
    else
      render json: {error: "Unable to create new user"}, status: 400
    end
  end

  def update
    @user = User.find_by_id(params[:user][:id])

    if @user.update(user_params)
      render json:  @user
    else
      render json: {
        error: "Failed To Update"
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
end
