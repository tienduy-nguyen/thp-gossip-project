class SessionsController < ApplicationController
  include SessionsHelper

  # GET Login
  def new
    
  end

  # POST Login - Authenticate account
  def create
    @user = current_user

    if @user && @user.authenticate(user_params[:password])
      flash[:success] = "You are logged succesfully!"
      redirect_to gossips_path
    else
      @user.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :new
    end
  end

  # DELETE - Logout
  def destroy
    session.delete(:user_id)
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
