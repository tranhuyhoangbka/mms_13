class Admin::ActivitiesController < ApplicationController
  before_action :admin_user

  def index
    @activities = Activity.order(created_at: :desc).paginate page: params[:page],
                                                    per_page: Settings.general.per_page
  end

  def destroy
    @activity = Activity.find params[:id]
    @activity.destroy
    redirect_to admin_activities_path, notice: t("activity.destroy_success")
  end
end
