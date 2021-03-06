class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by(username: params[:session][:username], email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      render json: @user
    else
      render json: {
        error: "Invalid Email or Password"
      }
    end
  end

  def get_current_user
    if logged_in?
      render json: current_user
    else
      render json: {
        notice: "No one logged in "
      }
    end
  end

  def destroy
    session.clear
    render json: {
      notice: "Successfully logged out"
    }
  end

end
