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
      flash[:danger] = user.errors.full_messages.first
      redirect_to new_user_path
    end
  end

  def show
    if session[:user]
      @user = User.find(session[:user])
      @addresses = @user.addresses
    else
      redirect_to login_path
    end
  end

  def update
    @user = User.find(session[:user])
    if @user.authenticate(params[:user][:password])
      @user.update(user_params)
      save_user?(@user)
    else
      flash[:danger] = 'Incorrect password'
      redirect_to edit_user_path
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

def save_user?(user)
  if user.save
    flash[:success] = 'Profile successfully updated'
    redirect_to dashboard_path
  else
    flash[:danger] = user.errors.full_messages.first
    redirect_to edit_user_path
  end
end
