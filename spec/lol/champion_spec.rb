require "lol"
require "spec_helper"

include Lol

describe Champion do
  describe "#new" do
    it "takes an option hash as argument" do
      expect { Champion.new({ :id => 1 }) }.not_to raise_error
    end

    it 'raises an error if an attribute is not allowed' do
      expect { Champion.new({ :foo => :bar }) }.to raise_error NoMethodError
    end

    it 'sets the given option hash as #raw' do
      options = { :id => 1 }
      expect(Champion.new(options).raw).to eq options
    end

    %w(id name active attack_rank defense_rank magic_rank difficulty_rank bot_enabled free_to_play bot_mm_enabled ranked_play_enabled).each do |attribute|
      it "sets #{attribute} if the hash contains #{attribute}" do
        game = Champion.new({ attribute => 'foo' })
        expect(game.send attribute).to eq 'foo'
      end

      it "sets #{attribute} if the hash contains #{camelize attribute}" do
        game = Champion.new({ camelize(attribute) => 'foo' })
        expect(game.send attribute).to eq 'foo'
      end
    end
  end

  describe "#raw" do
    it "is readonly" do
      expect { Champion.new.raw = "bar" }.to raise_error(NoMethodError)
    end
  end

  %w(id name active attack_rank defense_rank magic_rank difficulty_rank bot_enabled free_to_play bot_mm_enabled ranked_play_enabled).each do |attr|
    describe "##{attr}" do
      it "is readonly" do
        expect(subject).to_not respond_to "#{attr}="
      end
    end
  end
end
