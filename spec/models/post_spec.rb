require 'rspec/autorun'
require_relative '../spec_helper_lite'

stub_module 'ActiveModel::Conversion'
stub_module 'ActiveModel::Naming'

require_relative '../../app/models/post'

describe Post do
  before do
    @it = Post.new
  end

  it "should start with blank attributes" do
    @it.title.should be_nil
    @it.body.should be_nil
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

  it "should support setting attributes in the initializer" do
    it = Post.new(:title => "mytitle", :body => "mybody")
    it.title.should == "mytitle"
    it.body.should == "mybody"
  end

  describe "#publish" do
    before do
      @blog = mock "Blog"
      @it.blog = @blog
    end

    it "should add the post to the blog" do
      @blog.should_receive(:add_entry).with(@it).and_return(nil)
      @it.publish
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
        @it.publish(@clock)
      end
      it "should be a datetime" do
        @it.pubdate.class.should == DateTime
      end
      it "should be the current time" do
        @it.pubdate.should == @now
      end
    end


  end
end