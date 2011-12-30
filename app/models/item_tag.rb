class ItemTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :item, polymorphic: true
  delegate :name, to: :tag
end