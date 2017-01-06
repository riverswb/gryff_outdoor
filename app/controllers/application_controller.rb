class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart, :login_status

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def login_status
    if session[:user]
      @login_status = "Login"
      @login_path = login_path
    else
      @login_status = "Logout"
      @login_path = logout_path
    end
  end
end
