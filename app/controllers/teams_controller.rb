class TeamsController < ApplicationController
  def index
    @teams = @teams.paginate page: params[:page]
  end

  def show
    @users = @team.users.paginate page: params[:page]
  end
end
