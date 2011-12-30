require_relative '../spec_helper'

describe Post do
  before do
    @blog = Blog.new
  end

  def make_post(attrs)
    attrs[:title] ||= "Post #{attrs.hash}"
    post = @blog.new_post(attrs)
    post.publish.should be_true
    post
  end


end