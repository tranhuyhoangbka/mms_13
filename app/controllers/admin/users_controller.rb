class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, except: [:new, :create]  

  def new
    @user = User.new
    @positions = Position.all   
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user.create_success"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @positions = Position.all
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.update_success"
      redirect_to root_url
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :name, :password, :password_confirmation,
                                 :birthday, :position_id, :avatar
  end

  def set_user
    @user = User.find params[:id]
  end
end
