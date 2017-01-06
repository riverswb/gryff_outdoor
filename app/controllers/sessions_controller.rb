class SessionsController < ApplicationController

  def new
  end

  def destroy
    reset_session
    redirect_back fallback_location: login_path
  end

end