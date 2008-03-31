class HomeController < ApplicationController
  layout 'default'
  def index
    @page_title = "My blog"
    @posts = Post.find(:all, :order => 'id desc')
    if session[:id]
      @userinfo = User.find(:first, :conditions => [ 'id = ?', session[:id] ])
    end
  end

  def read
    @posts = Post.find(params[:id])
  end

end
