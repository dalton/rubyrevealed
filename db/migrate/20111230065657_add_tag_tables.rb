class AddTagTables < ActiveRecord::Migration

  class Post < ActiveRecord::Base; end
  class Tag < ActiveRecord::Base; end
  class ItemTag < ActiveRecord::Base
    belongs_to :tag
    belongs_to :item, :polymorphic => true
  end

  def self.up
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end
    create_table :item_tags do |t|
      t.integer :item_id
      t.string  :item_type
      t.integer :tag_id
    end
    Post.find_each do |post|
      Array(post.tags).each do |tag|
        tag_record = Tag.create!(:name => tag.to_s)
        ItemTag.create!(:item => post, :tag => tag_record)
      end
    end
    remove_column :posts, :tags
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Cannot be reversed"
  end
end