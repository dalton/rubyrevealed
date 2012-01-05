require "tag_list"
class Blog
  attr_reader :entries
  attr_writer :post_maker

  def initialize(entry_fetcher=Post.public_method(:most_recent)) # (ref:default_fetcher)
    @entry_fetcher = entry_fetcher # (ref:fetcher)
  end

  def title
    "Ruby Revealed"
  end

  def subtitle
    "Exposing the secrets of Ruby development wherever I find them "
  end

  def new_post(*args)
    post_maker.call(*args).tap do |p|
      p.blog = self
    end
  end

  def add_entry(entry)
    entry.save
  end

  def entries
    fetch_entries
  end

  def tags
    []
  end

  def filter_by_tag(tag)
    FilteredBlog.new(self, tag)
  end

  private
  def post_maker
    @post_maker || Post.public_method(:new)
  end

  def fetch_entries
    @entry_fetcher.()
  end

  class FilteredBlog < DelegateClass(Blog)
    include ::Conversions

    def initialize(blog, tag)
      super(blog)
      @tag = tag
    end

    def entries
      Taggable(super).tagged(@tag)
    end
  end

end