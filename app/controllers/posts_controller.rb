class PostsController < ApplicationController
  respond_to :html, :json

  include PresentersHelper

  before_filter :authenticate_author!, except: :show

  def new
    @post = @blog.new_post
  end

  def create
    @post = Taggable(@blog.new_post(params[:post]))
    if @post.publish
      redirect_to root_path, notice: "Post added!"
    else
      render "new"
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    respond_with(@post) do |format|
      format.html
      format.json { present(@post, self)}
    end
  end
end