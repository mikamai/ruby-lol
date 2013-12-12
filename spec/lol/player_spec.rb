require "lol"
require "spec_helper"

include Lol

describe Player do
  describe "#new" do
    it "takes an option hash as argument" do
      expect { Player.new({ :team_id => 1 }) }.not_to raise_error
    end

    it 'raises an error if an attribute is not allowed' do
      expect { Player.new({ :foo => :bar }) }.to raise_error NoMethodError
    end

    it 'sets the given option hash as #raw' do
      options = { :team_id => 1 }
      expect(Player.new(options).raw).to eq options
    end

    %w(champion_id summoner_id team_id).each do |attribute|
      it "sets #{attribute} if the hash contains #{attribute}" do
        game = Player.new({ attribute => 'foo' })
        expect(game.send attribute).to eq 'foo'
      end

      it "sets #{attribute} if the hash contains #{camelize attribute}" do
        game = Player.new({ camelize(attribute) => 'foo' })
        expect(game.send attribute).to eq 'foo'
      end
    end
  end

  describe "#raw" do
    it "is readonly" do
      expect { Player.new.raw = "bar" }.to raise_error(NoMethodError)
    end
  end

  %w(champion_id summoner_id team_id).each do |attr|
    describe "##{attr}" do
      it "is readonly" do
        expect(subject).to_not respond_to "#{attr}="
      end
    end
  end
end
