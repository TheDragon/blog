class AdminController < ApplicationController
  before_filter :ensure_admin, :except => [:login, :index]

  layout 'default'
  def index
    if !session[:id]
      render :action => 'login'
    else
      @page_title = "Blog Administration"
      @posts = Post.find(:all, :order => 'created_at desc')
    end
  end
  
  def login
    return unless request.post?
    @user = User.authenticate(params[:user][:username],params[:user][:password])
    if @user
      session[:id] = @user.id
      redirect_to :action => 'index'
    else
      render :action => 'login'
      flash[:warning] = "Username or password invalid. Please try again."
    end
  end
  
  def upload

  end

  def save_file

  end

  def new
    unless !session[:id]
      @post = Post.new
    else
      render :action => 'login'
    end
  end
  # TODO: Find out why the fuck this fails with an invalid auth token on the first submission attempt, but succeeds after a refresh.  
  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:message] = "Blog entry has been posted!"
      redirect_to :controller => 'home'
    else
      render :action => 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def delete
    @post = Post.find(params[:id])
    if @post.nil?
      flash[:message] = "That post doesn't exist!"
      redirect_to :action => 'index'
    else
      @post.destroy
      flash[:message] = "Blog entry deleted!"
      redirect_to :controller => 'home'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes!(params[:post])
      flash[:message] = "Post has been updated"
      redirect_to :controller => 'home'
    end
  end
end
