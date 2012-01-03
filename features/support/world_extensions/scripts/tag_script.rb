module KnowsScripts
  module Tag


    def find_tags_in_list(tags)
      visit "/"
      within("nav.tags") do
        tags.each do |tag|
          page.should have_content tag
        end
      end
    end

    def find_tags_on_post(tags)
      visit "/"
      within("article p span.tags") do
        tags.each do |tag|
          page.should have_content tag
        end
      end
    end

    def select_tag
      click_link "bananas"
    end

    def inspect_post_tags
      all('article').each do |article|
        article.find('.tags').should have_content "bananas"
        article.find('.tags').should_not have_content "apples"
        article.find('.tags').should_not have_content "cherries"
      end
    end
  end
end

World(KnowsScripts)
