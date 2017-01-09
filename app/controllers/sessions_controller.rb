class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user] = user.id
      session[:message] = "Logged in as #{user.first_name} #{user.last_name}"
      return redirect_to admin_dashboard_path if user.admin?
      redirect_to dashboard_path
    else
      byebug
      flash
      #sad_path
    end
  end

  def destroy
    reset_session
    redirect_back fallback_location: login_path
    # redirect_to login_path
  end

end
