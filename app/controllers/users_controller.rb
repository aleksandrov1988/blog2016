class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_edit, only: [:edit, :update, :destroy]

  def index
    @users = User.ordering.page(params[:page])
  end

  def show
    @posts = @user.posts.page(params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end


  def edit
  end


  def create
    @user = User.new(user_params)
    if @user.save
      if @current_user
        redirect_to @user, notice: 'Пользователь создан'
      else
        redirect_to login_path
      end
    else
      render :new
    end
  end


  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Пользователь изменен.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = 'Пользователь удален.'
    if @user == @current_user
      redirect_to logout_path
    else
      redirect_to users_path
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_edit
    unless @user.edit_by?(@current_user)
      redirect_to root_path, notice: 'Редактирование пользователя недоступно'
    end
  end
end
