require_relative "../actor"
require_relative "../../scripts/guest_script"
module KnowsActors
  class Guest < Actor
    include KnowsScripts::Guest

  end

  def guest
    @guest ||= Guest.new
  end
end

World(KnowsActors)