module KnowsActors
  class Guest < Actor

    def cannot_write_post
      visit "/"
      page.should_not have_content "New post..."
      visit "/posts/new"
      page.should have_content "You must log in before posting"
    end

  end

  def guest
    @guest ||= Guest.new
  end
end

World(KnowsActors)