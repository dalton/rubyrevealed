class Tag < ActiveRecord::Base
  has_many :item_tags
end

