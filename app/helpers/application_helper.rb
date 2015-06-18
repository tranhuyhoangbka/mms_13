module ApplicationHelper
  def logged_in_admin?
    user_signed_in? && current_user.is_admin?
  end
end
