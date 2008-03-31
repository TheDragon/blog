# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def is_admin?
    return true if session[:id] && User.find(session[:id]).admin
  end
end
