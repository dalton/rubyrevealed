require_relative '../spec_helper'

describe Blog do
  before do
    @it = Blog.new
  end

  describe "#entries" do
    def make_entry_with_date(date)
      @it.new_post(:pubdate => DateTime.parse(date), :title => date)
    end

    it "should be sorted in reverse-chronological order" do
      oldest = make_entry_with_date("2011-09-09")
      newest = make_entry_with_date("2011-09-11")
      middle = make_entry_with_date("2011-09-10")

      @it.add_entry(oldest)
      @it.add_entry(newest)
      @it.add_entry(middle)
      @it.entries.should == [newest, middle, oldest]
    end
  end
end