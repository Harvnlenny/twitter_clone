class PostsController < ApplicationController

  #before_action :signed_in_user, only: [:create, :destroy]
  before_action :current_user, only: [:create, :destroy]

  # TODO: show all tweets despite non-signed in user.
  def index
    @posts = Post.page(params[:page]).per(5).order('created_at DESC')
    respond_to do |format|
      format.html
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new

  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:success] = 'Chirp created!'
      redirect_to posts_url
    
    else
      flash[:danger] = @post.errors.full_messages.to_sentence
      redirect_to root_url
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = 'Chirp deleted!'
    redirect_to posts_url
  end

  private

    def post_params
      params.require(:post).permit(:body, :user_id, :username)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

    ## yet another `correct_user` imprementation
    # def correct_user
    #   @micropost = current_user.posts.find(params[:id])
    # rescue
    #   redirect_to root_url
    # end

end