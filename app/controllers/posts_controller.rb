class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :check_post_owner_or_admin, only: %i[edit update destroy]
  before_action :set_user

  def index
    @user = current_user
    feed = Feed.new(@user)
    @posts = feed.fetch_feed

    @notifications = current_user.notifications.unread if current_user.present?


    @posts = Post.includes(:tags).order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy!
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def post_params
    params.require(:post).permit(:body, :photo)
  end

  def check_post_owner_or_admin
    if @post.user != current_user && !current_user.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
