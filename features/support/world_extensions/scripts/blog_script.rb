module KnowsScripts
  module Blog

    def read_blog
      visit '/'
      page.should have_content "Ruby Revealed"
    end

  end
end

World(KnowsScripts)