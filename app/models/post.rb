require 'date'
require 'active_record'
require_relative '../../lib/fig_leaf'
class Post < ActiveRecord::Base

  validates :title, presence: true

  after_create :register_permalink

  attr_accessor :blog

  def self.first_before(date)
    first(conditions: ["pubdate < ?", date],
          order: "pubdate DESC")
  end

  def self.first_after(date)
    first(conditions: ["pubdate > ?", date],
          order: "pubdate ASC")
  end

  def self.most_recent(limit=10)
    order("pubdate DESC")
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

  private
  def register_permalink
    HTTParty.post('http://smooth-water-8493.heroku.com/shorten',
                  body: {
                      key: self.permalink,
                      link: Rails.application.routes.url_helpers.post_url(self, host: "http://severe-dawn-3970.herokuapp.com/")})
  end

end