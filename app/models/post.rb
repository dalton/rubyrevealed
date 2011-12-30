require 'date'
require 'active_record'
require_relative '../../lib/fig_leaf'
class Post < ActiveRecord::Base
  #include FigLeaf
  #hide ActiveRecord::Base, ancestors: true,
  #     :except => [Object, :init_with, :new_record?,
  #                 :errors, :valid?, :save, :record_timestamps, :id, :id=]
  #hide_singletons ActiveRecord::Calculations,
  #                ActiveRecord::FinderMethods,
  #                ActiveRecord::Relation

  validates :title, presence: true

  attr_accessor :blog

  def self.first_before(date)
    first(conditions: ["pubdate < ?", date],
          order: "pubdate DESC")
  end

  def self.most_recent(limit=10)
    all(order: "pubdate DESC", limit: limit)
  end

  def self.first_after(date)
    first(conditions: ["pubdate > ?", date],
          order: "pubdate ASC")
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