module KnowsScripts
  module Author

    def post_title
      "My Post Title"
    end

    def post_body
      "This is the body of my post."
    end

    def sign_in
      visit "/authors/sign_in"
      fill_in "Email", with: self.email
      fill_in "Password", with: self.password
      click_button "Sign in"
    end

    def write_post
      visit '/'
      click_link 'New post...'
      fill_in "Title", with: post_title
      fill_in "Body", with: post_body
      click_button "Create Post"
    end

    def read_post_i_wrote
      visit '/'
      page.should have_content post_title
      page.should have_content post_body
    end

    def read_post_as_guest
      visit '/'
      click_link "Logout"
      read_post_i_wrote
    end

  end
end

World(KnowsScripts)
