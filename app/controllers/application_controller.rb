class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart, :login_status

  helper_method :current_user

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def login_status
    if session[:user]
      @login_status = "Logout"
      @login_path = logout_path
    else
      @login_status = "Login"
      @login_path = login_path
    end
  end
end
