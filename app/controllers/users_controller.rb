class UsersController < ApplicationController
  
  # def index
  #   @users = User.find(params[:id])
  # end

  def new
    @user = User.new
    @user.avatar = params[:file]
  end

  @user.save!
  @user.avatar.url # => '/url/to/file.png'
  @user.avatar.current_path # => 'path/to/file.png'
  @user.avatar_identifier # => 'file.png'

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, notice: "Thank you for signing up!"
    else
      render 'new'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :username, :email, :avatar, :password, :password_confirmation)
  end

end
