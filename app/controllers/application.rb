# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '539b44ea63c89fa7b3856d15e82ee96f'
  def ensure_admin
    if session[:id] && User.find(session[:id]).admin
      return true
    else
      redirect_to :controller => 'home'
    end
  end
end
