class Admin::TeamsController < ApplicationController
  before_action :admin_user
  before_action :set_team, except: [:index, :new, :create]
  
  def index
    @teams = Team.paginate page: params[:page], per_page: Settings.general.per_page
  end

  def show
    @users = @team.users
  end

  def new
    @team = Team.new
    @users = User.normal.pluck :name, :id
  end

  def create
    @team = Team.new team_params
    if @team.save
      flash[:success] = t "team.create_success"
      redirect_to admin_teams_url
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
      redirect_to admin_team_path(@team)
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    flash[:success] = t "team.destroy_success"
    redirect_to admin_teams_url
  end

  private
  def team_params
    params.require(:team).permit :name, :description, :leader_id, user_ids: []
  end

  def set_team
    @team = Team.find params[:id]
  end
end
