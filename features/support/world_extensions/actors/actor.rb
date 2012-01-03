module KnowsActors

  require "capybara/dsl"
  require_relative "../scripts/blog_script"
require_relative "../scripts/tag_script"
  class Actor
    include ::Capybara::DSL
    include RSpec::Matchers
    include KnowsScripts::Blog
    include KnowsScripts::Tag
  end

  def actor
    @actor ||= Actor.new
  end

  def actor_is_playing(role)
    @actor = role
  end



end

World(KnowsActors)