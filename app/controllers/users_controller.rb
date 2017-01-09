class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user] = user.id
      session[:message] = "Logged in as #{user.first_name} #{user.last_name}"
      redirect_to dashboard_path
    else
      #add sad path
    end
  end

  def show
    @user = User.find(session[:user])
  end

  def update
    @user = User.find(session[:user])
    if @user.authenticate(user_params[:password])
      if @user.update(user_params)
        @user.save
        flash[:success] = "Profile successfully updated"
        redirect_to dashboard_path
      else
        render :edit
      end
    else
      flash[:alert] = "Incorrect password"
      render :edit
    end
  end

  def edit
    @user = User.find(session[:user])
  end
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
