class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    @team = @user.team
    @position = @user.position
    @projects = @user.projects.pluck(:name).join(", ")
    @skills = @user.skills.pluck(:name).join(", ")
  end
end
