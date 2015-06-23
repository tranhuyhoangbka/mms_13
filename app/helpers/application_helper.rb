module ApplicationHelper
  def logged_in_admin?
    user_signed_in? && current_user.is_admin?
  end

  def full_title title = ""
    if title.empty?
      t "general.title"
    else
      title + ' | ' + (t "general.title")
    end
  end
end
