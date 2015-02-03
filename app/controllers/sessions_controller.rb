class SessionsController < ApplicationController

  def new
    redirect_to root_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "You have successfully sign in"
    else
      flash[:error] = "Invalid email and password !!!"
      redirect_to sign_up_path
    end
  end

end
