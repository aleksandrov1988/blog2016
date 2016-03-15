class SessionsController < ApplicationController
  def new
  end

  def create
    @email = params[:email]
    @user = User.where("upper(email) = upper(?)", @email).first
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:notice] = "Неверное имя пользователя или пароль"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
