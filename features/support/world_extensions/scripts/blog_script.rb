module KnowsScripts
  module Blog

    def read_blog
      visit '/'
      page.should have_content "Ruby Revealed"
    end

    def number_of_posts_on_front_page
      visit '/'
      all("article").size
    end

    def read_older_posts
      click_link "Older"
      page.should have_content "Newer"
    end

  end
end

World(KnowsScripts)