class UsersController < ApplicationController
  include SessionsHelper

  before_action :logged_in_user, only: [:show, :index]
  # GET /users
  def index
    @users = User.all.order(updated_at: :desc)
  end

  # GET /users/:id
  def show
    @user = User.find_by(:id => params[:id])
  end

  # GET /users/:first_name
  def show_by_first_name
    @user = User.find_by(:first_name => params[:first_name])
  end

  # GET /users/new
  def new
    @user = current_user
    if !@user.nil? 
      redirect_to gossips_path
    else
      @user = User.new
    end
  end

  # POST /users
  def create 
    @user = User.new(email: user_params[:email], 
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation])
    if @user.save
      flash[:success] = "Create account succesffuly!"
      log_in @user
      redirect_back_or @user
    else
      @user.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :new
    end
  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
    @city_id = City.all.sample.id
  end

  # PUT /users/:id/edit
  def update_profile
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Update user profile succesfully!"
      redirect_to users_path
    else
      @user.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :edit
    end
  end


  # DELETE /uses/:id
  def destroy

  end

  # GET /users/:id/settings
  def settings

  end

  # PUT /users/:id/settings
  def update_settings

  end

  private
    def user_params
      params.require(:user).permit(
      :username,
      :first_name, 
      :last_name, 
      :age, 
      :description, 
      :city,
      :email,
      :password,
      :password_confirmation
      )
    end
end
