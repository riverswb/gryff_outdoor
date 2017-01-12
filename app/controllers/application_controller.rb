class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart, :login_status, :get_items

  helper_method :current_user, :to_pennies

  def get_items
    @search = Item.search(params[:q])
    @q = Item.ransack(params[:q])
    @items = @q.result.includes(:category)
  end

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def login_status
    if session[:user]
      @login_status = "Log out"
      @login_path = logout_path
    else
      @login_status = "Log in"
      @login_path = login_path
    end
  end

  def to_pennies(amount)
    (amount * 100).to_i.to_s
  end
end
