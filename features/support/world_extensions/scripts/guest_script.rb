module KnowsScripts
  module Guest
    def cannot_write_post
      visit "/"
      page.should_not have_content "New post..."
      visit "/posts/new"
      page.should have_content "You must log in before posting"
    end

    def read_post(post)
      click_link post.title
    end
  end
end
