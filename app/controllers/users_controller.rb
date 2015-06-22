class UsersController < ApplicationController
  
  def new
    @user = User.new
    @user.avatar = params[:file]
  end

  def index
    @users = User.all
  end

  #@user.save!
  #@user.avatar.url # => '/url/to/file.png'
  #@user.avatar.current_path # => 'path/to/file.png'
  #@user.avatar_identifier # => 'file.png'

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @relationship = Relationship.where(
      follower_id: current_user.id,
      followed_id: @user.id
    ).first_or_initialize if current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, notice: "Thank you for signing up!"
    else
      render 'new'
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

private

  def user_params
    params.require(:user).permit(:name, :username, :email, :avatar, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
