require 'forwardable'

module Conversions
  private
  def TagList(value)
    return value if value.is_a?(TagList)
    TagList.new(value)
  end

  def Taggable(item, tag_storage=::TagStorage.new(item))
    case item
      when ::Class, ::ActiveRecord::Relation
        item.extend(::TaggableRelation)
      else
        item.extend(::TaggableRecord)
        item._tag_storage = tag_storage
    end
    item
  end
end

include Conversions


class TagList
  extend Forwardable
  include Enumerable
  attr_reader :tags

  def_delegators :tags, :empty?, :to_a, :each

  def initialize(tags)
    case tags
      when Array
        @tags = tags
      else
        @tags = tags.to_s.split(/\W+/)
    end
    @tags.uniq!
    @tags.each(&:downcase!)
  end

  def to_s
    tags.join(", ")
  end

  def to_ary
    @tags
  end

  def +(other)
    self.class.new(to_a + other.to_a)
  end

  def ==(other)
    to_a == Array(other)
  end

  def alphabetical
    self.class.new(tags.sort)
  end
end