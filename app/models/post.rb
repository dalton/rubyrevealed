require 'date'
require 'active_record'
class Post < ActiveRecord::Base
  validates :title, presence: true

  attr_accessor :blog

  def self.first_before(date)
    first(conditions: ["pubdate < ?", date],
          order:      "pubdate DESC")
  end

  def first_after(date)
    first(conditions: ["pubdate > ?", date],
          order:      "pubdate ASC")
  end

  def publish(clock=DateTime)
    return false unless valid?
    self.pubdate = clock.now
    blog.add_entry(self)
  end

  def prev
    self.class.first_before(pubdate)
  end

  def next
    self.class.first_after(pubdate)
  end

  def up
    THE_BLOG
  end

  def picture?
    image_url.present?
  end
end