class Admin::ProjectsController < ApplicationController
  before_action :admin_user
  before_action :current_project, except: [:new, :index, :create]
  before_action :get_all_users, only: [:new, :edit, :update]
  before_action :get_all_teams, only: [:new, :edit]

  def index
    @q = Project.ransack params[:q]
    @projects = @q.result.paginate page: params[:page],
                                   per_page: Settings.general.per_page
  end

  def show
    @team = @project.team
    @user = @project.leader
  end

  def new
    @project = Project.new
    @users = User.order name: :desc
  end

  def create
    @project = Project.new project_params
    if @project.save
      flash[:success] = t "project.project_create"
      redirect_to admin_projects_path
    else
      render :new
    end
  end

  def edit
    @users = @project.team.users.order name: :desc
  end

  def update
    if @project.update_attributes project_params
      redirect_to admin_project_path @project
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to admin_projects_path
  end

  private
  def project_params
    params.require(:project).permit :name, :abbreviation, :team_id,
                                    :leader_id, :start_date, :end_date, user_ids: []
  end

  def current_project
    @project = Project.find params[:id]
  end

  def get_all_users
    @users = User.paginate page: params[:page]
  end

  def get_all_teams
    @teams = Team.order name: :desc
  end
end
