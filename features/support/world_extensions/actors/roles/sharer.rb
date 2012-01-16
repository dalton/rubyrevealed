require_relative "../actor"
require_relative "../../scripts/sharer_script"
module KnowsActors
  class Sharer < Actor
    include KnowsScripts::Sharer

  end

  def sharer
    @sharer ||= Sharer.new
  end
end

World(KnowsActors)