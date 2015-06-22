class HomeController < ApplicationController
  def index
    @users = User.all
    @posts = Post.all
  end

  def timeline
    @post = Post.all
  end
end
