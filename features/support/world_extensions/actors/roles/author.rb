require_relative "../actor"
require_relative "../../scripts/author_script"
module KnowsActors
  class Author < Actor
    include KnowsScripts::Author

    attr_accessor :email, :password

    def initialize
      @email = "email@rubyrevealed.com"
      @password = "password"
      @password_confirmation = "password"

      Factory(:author, email: @email, password: @password, password_confirmation: @password)
    end

  end

  def author
    @author ||= Author.new
  end
end

World(KnowsActors)