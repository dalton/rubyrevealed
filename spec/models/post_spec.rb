require_relative '../spec_helper'


describe Post do
  before do
    @it = Post.new(title: "TITLE")
    @ar = @it
  end

  it "should support reading and writing a title" do
    @it.title = "foo"
    @it.title.should == "foo"
  end

  it "should support reading and writing a post body" do
    @it.body = "foo"
    @it.body.should == "foo"
  end

  it "should support reading and writing a blog reference" do
    blog = Object.new
    @it.blog = blog
    @it.blog.should == blog
  end

  it "should not be valid with a blank title" do
    [nil, "", " "].each do |bad_title|
      @it.title = bad_title
      @it.should_not be_valid
    end
  end

  it "should be valid with a non-blank title" do
    @it.title = "x"
    @it.should be_valid
  end

  describe "#publish" do
    before do
      @blog = mock "Blog"
      @it.blog = @blog
      @it.title = "x"
    end

    it "should add the post to the blog" do
      @blog.should_receive(:add_entry).with(@it).and_return(nil)
      @it.publish
    end

    describe "given an invalid post" do
      before do @ar.should_receive(:valid?).and_return(false) end

      it "should not add the post to the blog" do
        @blog.should_not_receive(:add_entry)
        @it.publish
      end

      it "should return false" do
        @it.publish.should == false
      end
    end
  end

  describe "#pubdate" do
    describe "before publishing" do
      it "should be blank" do
        @it.pubdate.should be_nil
      end
    end

    describe "after publishing" do
      before do
        @clock = stub("Clock")
        @now = DateTime.parse("2011-09-11T02:56")
        @clock.should_receive(:now).and_return(@now)
        @it.blog = stub("Blog").as_null_object
        @it.title = "x"
        @it.publish(@clock)
      end
      it "should be the current time" do
        @it.pubdate.should == @now
      end
    end
  end

  describe "#picture?" do
    it "should be true when the post has a picture URL" do
      @it.image_url = "http://example.org/foo.jpg"
      @it.picture?.should be_true
    end

    it "should be false when the post has no picture URL" do
      @it.image_url = ""
      @it.picture?.should be_false
    end
  end
end