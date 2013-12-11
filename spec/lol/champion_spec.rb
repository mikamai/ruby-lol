require "lol"
require "spec_helper"

include Lol

describe Champion do
  describe "#new" do
    it "takes an option hash as argument" do
      expect { Champion.new({ :foo => :bar }) }.not_to raise_error
    end
  end

  describe "#raw" do
    it "is readonly" do
      expect { Champion.new.raw = "bar" }.to raise_error(NoMethodError)
    end
  end

  [:id, :name, :active, :attack_rank, :defense_rank, :magic_rank, :difficulty_rank, :bot_enabled,
    :free_to_play, :bot_mm_enabled, :ranked_play_enabled].each do |attr|
    describe "##{attr}" do
      it "accepts it as constructor" do
        expect_init_attribute(Champion, attr)
      end

      it "is readonly" do
        expect_read_only_attribute(Champion, attr)
      end
    end
  end
end
