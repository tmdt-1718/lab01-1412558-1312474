class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new]
  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = "The post was successfully created"
      redirect_to @post
    else render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    # @post.user == User.find(params[:user_id])
    @post.update(num_views: @post.num_views + 1)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "The post was successfully updated"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:danger] = "The post was successfully deleted"
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :cover)
    end
end
