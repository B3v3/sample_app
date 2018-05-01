class SessionsController < ApplicationController
before_action :not_logged_in?, only: [:new]


  def new
  end

  def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if @user && @user.authenticate(params[:session][:password])
          if @user.activated?
          log_in @user
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          redirect_back_or(@user)
        else
          flash[:danger] = "Please activate your account"
          redirect_to root_path
        end
        else
          flash.now[:danger] = "Invalid email/password combination"
        render 'new'
      end

  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def not_logged_in?
   if current_user
     redirect_to root_path
   end
  end

end
