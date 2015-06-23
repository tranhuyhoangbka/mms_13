class Admin::TeamsController < ApplicationController
  before_action :admin_user
  before_action :set_team, except: [:new, :create]
  
  def new
    @team = Team.new
  end

  def create
    @team = Team.new team_params
    if @team.save
      flash[:success] = t "team.create_success"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @users_of_team = @team.users
    @no_team_users = User.normal.no_team_users
  end

  def update
    if @team.update_attributes team_params
      flash[:success] = t "team.update_success"
      redirect_to root_url
    else
      render "edit"
    end
  end

  private
  def team_params
    params.require(:team).permit :name, :description, :team_leader, user_ids: []
  end

  def set_team
    @team = Team.find params[:id]
  end
end
