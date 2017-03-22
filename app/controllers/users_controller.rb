class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = ["You have successfully registered. Please log in."]
      redirect_to new_user_path
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    @user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], city: params[:city], state: params[:state])
    if @user.save
      flash[:notice] = ['Profile has been updated.']
      redirect_to events_path
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to :back
    end
  end

  protected
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :confirm_pw, :city, :state)
    end
end
