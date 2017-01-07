class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email params[:email])
    if user.authenticate(params[:password])
      session[:user] = user.id
      session[:message] = "Logged in as #{user.first_name} #{user.last_name}"
      redirect_to dashboard_path
    else
      #sad_path
    end
  end

  def destroy
    reset_session
    redirect_back fallback_location: login_path
  end

end