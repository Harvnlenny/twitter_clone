class PostsController < ApplicationController

  #before_action :signed_in_user, only: [:create, :destroy]
  #before_action :correct_user, only: [:destroy]

  # TODO: show all tweets despite non-signed in user.
  def index
    @posts = Post.page(params[:page]).per(5)
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
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    
    else
      flash[:danger] = @post.errors.full_messages.to_sentence
      redirect_to root_url
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :user_id)
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