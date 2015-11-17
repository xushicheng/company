class BlogsController < ApplicationController
  before_action :is_admin?, except: [:index, :show]

  def index
    @blogs = Blog.paginate(:page => params[:page])
  end

  def show
    @blog = Blog.find(params[:id])
    @comments = @blog.comments.paginate(:page => params[:page])
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, flash.now[:notice] => 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @blog = Blog.new(blog_params)
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end

  private
    def is_admin?
      unless logged_in? && current_user.admin?
        redirect_to blogs_path
      end
    end
    helper_method :is_admin?

    def blog_params
      params.require(:blog).permit(:title, :tag, :content)
    end
end
