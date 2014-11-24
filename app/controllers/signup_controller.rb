class SignupController < ApplicationController
  before_action :redirect_logged_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path, notice: t('flash.signup.create.notice')
    else
      render :new
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :login, :password, :password_confirmation)
  end
end
