Given /^I am an author$/ do
  author.sign_in
  actor_is_playing author
end

Given /^I am a guest$/ do
  actor_is_playing guest
end

