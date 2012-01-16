Given /^I am reading the blog$/ do
  actor.read_blog
end

When /^I write a post$/ do
  actor.write_post
end

Then /^I should see the post$/ do
  actor.read_post_i_wrote
end

Then /^everyone can read the post$/ do
  actor.read_post_as_guest
end


Then /^I should not be able to write a post$/ do
  actor.cannot_write_post
end

When /^I view the post$/ do
  actor.read_post(post)
end

Then /^the permalink should be a short url$/ do
  actor_is_playing sharer
  actor.short_permalink?
end
