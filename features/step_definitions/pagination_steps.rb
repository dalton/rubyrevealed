Given /^there (?:is|are) (\d+) posts? in the blog$/ do |number_of_posts|
  number_of_posts.to_i.times do
    Factory(:post)
  end
  visit "/"
end

Then /^I should see the (\d+) most recent posts$/ do |number_of_posts|
  actor.number_of_posts_on_front_page.should == number_of_posts.to_i
end

Then /^I should be able to get to older posts$/ do
  actor.read_older_posts
end

Then /^I should not be able to navigate to older posts$/ do
  page.should_not have_content "Older"
end

