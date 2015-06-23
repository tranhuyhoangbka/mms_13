class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  protected
  
  def admin_user
    unless current_user.is_admin?
      flash[:danger] = t "general.not_admin"
      redirect_to root_url
    end
  end
end
