class Admin::UsersController < ApplicationController
  def index
    @q = User.normal.ransack params[:q]
    @users = @q.result.paginate page: params[:page],
                                per_page: Settings.general.per_page
  end

  def show
    respond_to do |format|
      format.html
      format.csv {send_data @user.to_csv}
    end
  end

  def new
    @user = User.new
    @positions = Position.all
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user.create_success"
      redirect_to admin_user_path(@user)
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
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "user.delete_success"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :email, :name, :password, :password_confirmation,
                                 :birthday, :position_id, :avatar
  end
end
