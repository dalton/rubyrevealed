module TaggableRelation
  include ::Conversions

  def all_tags_alphabetical
    all_tags.alphabetical
  end

  def all_tags
    TagList(ItemTag.where(item_type: "Post").includes(:tag).map(&:name))
  end

  def new(attrs={}, &block)
    attrs = attrs.dup
    tags = attrs.delete(:tags)
    Taggable(super(attrs, &block)).tap do |item|
      item.tags = tags
    end
  end

  def tagged(tag)
    joins("JOIN item_tags ON item_tags.item_id = #{table_name}.id AND " \
        "item_tags.item_type = \"#{klass.name}\"").
        joins("JOIN tags ON item_tags.tag_id = tags.id").
        where("tags.name = ?", tag)
  end
end