Given /^I am reading the blog$/ do
  visit '/'
end

When /^I create a post$/ do
  click_link 'New Entry'
end

Then /^I should see the post$/ do
  page.should have_content 'Hello'
end
