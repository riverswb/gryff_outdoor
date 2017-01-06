class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Logged in as #{@user.first_name} #{@user.last_name}"
      return redirect_to "/dashboard"
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end