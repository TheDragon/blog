class HomeController < ApplicationController
  # Moved to ApplicationController; see notes there.
  # layout 'default'

  def index
    @page_title = "My blog"
    @posts = Post.find(:all, :order => 'id desc')
    if session[:id]
      # You can also pass a hash to :conditions, which is sometimes easier to read
      # than interpolated strings.  This line and the one you wrote are equivalent.
      # @userinfo = User.find(:first, :conditions => { :id => session[:id] }
      @userinfo = User.find(:first, :conditions => [ 'id = ?', session[:id] ])
    end
  end

  def read
    # Generally when you're using a single model, this variable should be called
    # '@post'. However, you can name things @asdfbbq if you wanted.
    @posts = Post.find(params[:id])
  end
end
