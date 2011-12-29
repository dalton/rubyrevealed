require 'rspec/autorun'
require 'ostruct'
require_relative '../../app/models/blog'

describe Blog do
  before do
    @it = Blog.new
  end

  it "should have no entries" do
    @it.entries.should be_empty
  end

  describe "#new_post" do
    before do
      @new_post = OpenStruct.new
      @it.post_maker= -> { @new_post }
    end

    it "should return a new post" do
      @it.new_post.should == @new_post
    end

    it "should set the post's blog reference to itself" do
      @it.new_post.blog.should == @it
    end

    it "should accept an attribute hash on behalf of the post maker" do
      post_maker = mock "Post Maker"
      post_maker.should_receive(:call).with({:x => 42, :y => 'z'}).and_return(@new_post)
      @it.post_maker = post_maker
      @it.new_post(:x => 42, :y => 'z')
    end
  end

  describe "#add_entry" do
    it "should add the entry to the blog" do
      entry = OpenStruct.new(pubdate: "a")
      @it.add_entry(entry)
      @it.entries.should include(entry)
    end
  end

  describe "#entries" do
    def stub_entry_with_date(date)
      OpenStruct.new(pubdate: DateTime.parse(date))
    end

    it "should be sorted in reverse-chronological order" do
      oldest = stub_entry_with_date("2011-09-09")
      newest = stub_entry_with_date("2011-09-11")
      middle = stub_entry_with_date("2011-09-10")

      @it.add_entry(oldest)
      @it.add_entry(newest)
      @it.add_entry(middle)
      @it.entries.should == [newest, middle, oldest]
    end

    it "should be limited to 10 items" do
      10.times do |i|
        @it.add_entry(stub_entry_with_date("2011-09-#{i+1}"))
      end
      oldest = stub_entry_with_date("2011-08-30")
      @it.add_entry(oldest)
      @it.should have(10).entries
      @it.entries.should_not include(oldest)
    end
  end
end