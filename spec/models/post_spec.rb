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
end