require_relative '../spec_helper_lite'
require_relative '../../app/presenters/picture_post_presenter'
require 'ostruct'

describe PicturePostPresenter do
  before do
    @post = OpenStruct.new(
        title: "TITLE",
        body: "BODY",
        pubdate: "PUBDATE"
    )
    @template = stub "Template"
    @it = PicturePostPresenter.new(@post, @template)
  end

  it "delegates mehtod calls to the post" do
    @it.title.should == "TITLE"
    @it.body.should == "BODY"
    @it.pubdate.should == "PUBDATE"
  end

  it "renders itself with the apropriate partial" do
    @template.should_receive(:render).with(
        partial: "/posts/picture_body", locals: {post: @it}
    ).and_return("THE_HTML")
    @it.render_body.should == "THE_HTML"
  end
end