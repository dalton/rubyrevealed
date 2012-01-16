module KnowsScripts
  module Sharer
    def short_permalink?
      page.should have_content "permalink: rb"
    end
  end
end