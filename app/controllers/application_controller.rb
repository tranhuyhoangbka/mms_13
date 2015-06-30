class ApplicationController < ActionController::Base
  load_and_authorize_resource except: [:home, :about, :contact],
                              unless: :devise_controller?
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :select_language

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t "general.not_admin"
    redirect_to root_url
  end

  protected
  def select_language
    I18n.locale = params[:locale] if params[:locale]
  end
end
