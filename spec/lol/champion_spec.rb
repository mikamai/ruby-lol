require "lol"
require "spec_helper"

include Lol

describe Champion do
  describe "#new" do
    it "takes an option hash as argument" do
      expect { Champion.new({ :foo => :bar }) }.not_to raise_error
    end
  end
end
