class LoginController < ApplicationController
  before_action :redirect_logged_user, except: %w[destroy]

  def new
  end

  def create
    @user = Authenticator.authenticate(params[:credential], params[:password])

    if @user
      reset_session
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      redirect_to login_path, alert: t('flash.login.create.alert')
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
