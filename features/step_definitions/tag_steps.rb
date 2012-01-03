When /^I create a post with tags$/ do
  actor.write_post(tags: %w(tag post test))
end

Then /^the tags should be added to the tag list$/ do
  actor.find_tags_in_list(%w(tag post test))
end

Then /^the tags should be attached to the post$/ do
  actor.find_tags_on_post(%w(tag post test))
end

Given /^tagged posts$/ do
  30.times do
    Factory(:post)
  end
  visit "/"
end

When /^I select a tag$/ do
  actor.select_tag
end

Then /^I should only see posts that have that tag$/ do
  actor.inspect_post_tags
end
