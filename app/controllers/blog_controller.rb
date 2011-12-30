class BlogController < ApplicationController
  def index
    if params[:tag].present?
      @blog = @blog.filter_by_tag(params[:tag])
    end
  end
end
