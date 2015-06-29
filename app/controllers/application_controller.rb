class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :select_language

  protected
  
  def admin_user
    unless current_user.is_admin?
      flash[:danger] = t "general.not_admin"
      redirect_to root_url
    end
  end

  def select_language
    I18n.locale = params[:locale] if params[:locale]
  end
end
