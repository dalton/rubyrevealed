FactoryGirl.define do

  sequence :title do |n|
    "Post Title #{n}"
  end

  sequence :body do |n|
    "Post Body #{n}"
  end


  factory :post do
    title
    body
    after_create{|post| Taggable(post).tags = %w(bananas apples cherries).shuffle[1]; post.save}
  end
end


