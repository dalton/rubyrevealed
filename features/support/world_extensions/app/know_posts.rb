module KnowsPosts
  def post
    @post ||= THE_BLOG.entries.last || Factory(:post)
  end
end

World(KnowsPosts)