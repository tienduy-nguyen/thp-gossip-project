class UsersController < ApplicationController
  include SessionsHelper

  before_action :user_filter, only: [:show, :edit, :update, :destroy]
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
    @user = session[:user_id]
    if !@user.nil? 
      redirect_to gossips_path
    else
      @user = User.new
      @city_id = City.all.sample.id
    end
  end

  # POST /users
  def create 
    @user = User.new(user_params)
    @user.password = user_params[:password]
    if @user.save
      flash[:sucess] = "Create User Sucessfull!"
      session[:user_id] = @user.id
      redirect_to users_path
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
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Update User succesfull!"
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

  def login 
    @user = User.find_by_email(user_params[:email])
    if @user.password == users_params[:password]
      give_token
    else
      redirect_to root_path
    end

  end

  private
    def user_filter
      @user = User.find_by(:id => params[:id]) or not_found
    end
end
