class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to events_path
    else
      if !@user
        flash[:notice] = ["Please enter a valid email address."]
      else
        flash[:notice] = ["Invalid login credentials."]
      end
      redirect_to new_user_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
