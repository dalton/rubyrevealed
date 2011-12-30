class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.datetime :pubdate
      t.string :title
      t.text :body
      t.string :image_url

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
