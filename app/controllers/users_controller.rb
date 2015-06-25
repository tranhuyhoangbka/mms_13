class UsersController < ApplicationController
  before_action :set_user

  def show    
    @team = @user.team
    @position = @user.position
    @projects = @user.projects.pluck(:name).join(", ")
    @skills = @user.skills.pluck(:name).join(", ")
  end

  def update    
    if @user.update_attributes user_params
      respond_to do |format|
        format.html {redirect_to @user, notice: t("user.update_success")}
        format.js
      end
    else
      redirect_to @user, alert: t("user.update_fail")
    end    
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
                                 :role, :avatar, :birthday, skill_ids: [], 
                                 skill_users_attributes: [:id, :user_id, :skill_id, :level,
                                                             :experience_year, :_destroy]
  end

  def set_user
    @user = User.find params[:id]
  end
end
