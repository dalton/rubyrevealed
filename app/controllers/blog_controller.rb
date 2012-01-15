class BlogController < ApplicationController
  include ::Pagination::Conversions

  def index
    if params[:tag].present?
      @blog = @blog.filter_by_tag(params[:tag])
    end
    @entries = Paginated(@blog.entries)
    if params[:page].present?
      @entries.page = params[:page].to_i
    end
  end
end
