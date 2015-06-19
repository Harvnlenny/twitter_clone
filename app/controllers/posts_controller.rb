class PostsController < ApplicationController

  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  # TODO: show all tweets despite non-signed in user.
  def index
    @posts = Post.page(params[:page]).per(5)
    
  end

  def create
    @post = current_user.posts.build(post_params)
    if @tweet.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      flash[:danger] = @tweet.errors.full_messages.to_sentence
      redirect_to root_url
    end
  end

  def destroy
    @tweet.destroy
    redirect_to root_url
  end

  private

    def tweet_params
      params.require(:post).permit(:content)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

    ## yet another `correct_user` imprementation
    # def correct_user
    #   @micropost = current_user.tweets.find(params[:id])
    # rescue
    #   redirect_to root_url
    # end

end