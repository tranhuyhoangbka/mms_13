class Admin::TeamsController < ApplicationController
  before_action :admin_user
  before_action :set_team, except: [:index, :new, :create]
  
  def index
    @teams = Team.paginate page: params[:page], per_page: Settings.general.per_page
  end

  def show
    @users = @team.users
    respond_to do |format|
      format.html
      format.csv {send_data @team.to_csv}
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new team_params
    if @team.save
      flash[:success] = t "team.create_success"
      redirect_to admin_team_path(@team)
    else
      render :new
    end
  end

  def edit
    @users_of_team = @team.users
    @no_team_users = User.normal.no_team_users
    @leader = @team.leader
  end

  def update
    if @team.update_attributes team_params
      respond_to do |format|
        format.html {redirect_to admin_team_path(@team), notice: t("team.update_success")}
        format.js
      end
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
