class HomeController < ApplicationController
  layout 'default'
  def index
    @page_title = "My blog"
    @posts = Post.find(:all, :order => 'id desc')
    if session[:id]
      @userinfo = User.find(:first, :conditions => [ 'id = ?', session[:id] ])
    end
  end

  def add_comment
    if session[:id]
      @comment = Comment.new
    else
      render :controller => 'admin', :action => 'login'
    end
  end

  def post_comment
    @comment = Comment.new(params[:comment])
    @comment.post = Post.find(params[:id], :conditions => { :id => params[:id] })
    if @comment.save
      flash[:message] = 'Comment successfully posted.'
      redirect_to :controller => 'home'
    else
      render :action => 'add_comment'
    end
  end  

  def logout
    session.delete
    redirect_to :controller => 'home'
  end

  def webcam
    
  end

  def read
    @posts = Post.find(params[:id])
  end

end
