class Admin::BaseAdminController < ApplicationController
  before_filter :authorize_admin

  private
  def authorize_admin
    unless current_user.is_admin?
      flash[:error] = t "general.admin_only"
      redirect_to :root
    end
  end
end
