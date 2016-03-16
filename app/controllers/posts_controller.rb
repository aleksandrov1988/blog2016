class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create]
  before_action :check_editor, only: [:new, :create]
  before_action :check_edit, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  def show
  end


  def new
    @post = @user.posts.build
  end

  def edit
  end

  def create
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Запись создана.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Запись изменена'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to @post.user, notice: 'Запись удалена.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def check_editor
    unless Post.create_by?(@user, @current_user)
      redirect_to root_path, notice: 'Доступ запрещен', status: 403
    end
  end

  def check_edit
    unless @post.edit_by?(@current_user)
      redirect_to root_path, notice: 'Доступ запрещен', status: 403
    end
  end
end
