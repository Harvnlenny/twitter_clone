class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
 
  if @user.save
    redirect_to @user, notice: "Thank you for signing up!"
  else
    render 'new'
  end
end

private

  def user_params
    params.require(:user).permit(:name, :email_address, :avatar, :password, :password_confirmation)
  end

end

	# def new
	# 	@user = User.new
	# 	@user.avatar = params[:file]
	# end

	# I'm not sure what these do yet. Commenting for now.
	# @user.save!
	# @user.avatar.url # => '/url/to/file.png'
	# @user.avatar.current_path # => 'path/to/file.png'
	# @user.avatar_identifier # => 'file.png'



