class AdminController < ApplicationController
  before_filter :ensure_admin, :except => [:login, :index]

  # If you want to use a global layout for all controllers, just specify this
  # in ApplicationController.
  # layout 'default'

  def index
    # There's usually no need to use the ! operator in if/unless tests, unless
    # you *really* specifically need to.
    # if !session[:id]
    unless session[:id]  # Does the same as above if statement.
      render :action => 'login'
    else
      @page_title = "Blog Administration"
      @posts = Post.find(:all, :order => 'created_at desc')
    end
  end
  
  def login
    return unless request.post?
    # Ideally, you would sanitize the username and password, since it's coming
    # from the outside world, but since User.authenticate passes the username to
    # User.find_by_username, it's basically the same as specifying conditions.
    @user = User.authenticate(params[:user][:username],params[:user][:password])
    if @user
      session[:id] = @user.id
      redirect_to :action => 'index'
    else
      render :action => 'login'
      flash[:warning] = "Username or password invalid. Please try again."
    end
  end
  
  def new
    # This if statement does the same.  See notes above.
    # unless !session[:id]
    if session[:id]
      @post = Post.new
    else
      render :action => 'login'
    end
  end
  
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
