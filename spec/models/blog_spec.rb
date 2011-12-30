require 'rspec/autorun'
require 'ostruct'
require_relative '../../app/models/blog'
require_relative '../../app/models/post'

describe Blog do
  before do
    @entries = []
    @it = Blog.new(->{@entries})
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
      entry = stub "Entry"
      entry.should_receive(:save)
      @it.add_entry(entry)
    end
  end
end