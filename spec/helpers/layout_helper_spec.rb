require "rails_helper"

describe LayoutHelper do
  describe "#title" do
    it "sets content_for(:title)" do
      helper.title("foo")
      expect(view.content_for(:title)).to eq "foo"
    end
    it "sets @show_title to true by default" do
      helper.title("foo")
      expect(helper.show_title?).to be_truthy
    end
    it "sets @show_title to false" do
      helper.title("foo", false)
      expect(helper.show_title?).to be_falsey
    end
  end
  describe "#header_right" do
    it "sets content_for(:header_right)" do
      helper.header_right("foo")
      expect(view.content_for(:header_right)).to eq "foo"
    end
    it "sets @show_header_right to true by default" do
      helper.header_right("foo")
      expect(helper.show_header_right?).to be_truthy
    end
    it "sets @show_header_right to false" do
      helper.header_right("foo", false)
      expect(helper.show_header_right?).to be_falsey
    end
  end
  describe "#flash_div" do
    it "returns nil if flash at given level is not present" do
      flash[:notice] = nil
      expect(helper.flash_div(:notice)).to be_nil
    end
    it "returns message if flash at given level is present" do
      flash[:notice] = "Notice"
      expect(helper.flash_div(:notice)).to include "Notice"
    end
    it "sets bootstrap class special for notice level" do
      flash[:notice] = "Notice"
      expect(helper.flash_div(:notice)).to include "alert-info"
    end
  end
end
