class Blog
  attr_reader :entries
  attr_writer :post_maker

  def initialize(entry_fetcher=Post.public_method(:all)) # (ref:default_fetcher)
    @entry_fetcher = entry_fetcher # (ref:fetcher)
  end

  def title
    "Watching Paint Dry"
  end

  def subtitle
    "The trusted source for paint drying news"
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
    fetch_entries.sort_by { |e| e.pubdate }.reverse.take(10)
  end

  private
  def post_maker
    @post_maker || Post.public_method(:new)
  end

  def fetch_entries
    @entry_fetcher.()
  end

end