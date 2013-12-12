require "spec_helper"
require "lol"
require "json"

include Lol

describe Game do
  describe '#new' do
    it "takes an option hash as argument" do
      expect { Game.new({ :game_id => 1 }) }.not_to raise_error
    end

    it 'raises an error if an attribute is not allowed' do
      expect { Game.new({ :foo => :bar }) }.to raise_error NoMethodError
    end

    it 'sets the given option hash as #raw' do
      options = { :game_id => 1 }
      expect(Game.new(options).raw).to eq options
    end

    %w(champion_id create_date_str game_id game_mode game_type invalid level map_id spell1 spell2 sub_type team_id).each do |attribute|
      it "sets #{attribute} if the hash contains #{attribute}" do
        game = Game.new({ attribute => 'foo' })
        expect(game.send attribute).to eq 'foo'
      end

      it "sets #{attribute} if the hash contains #{camelize attribute}" do
        game = Game.new({ camelize(attribute) => 'foo' })
        expect(game.send attribute).to eq 'foo'
      end
    end

    %w(fellow_players statistics).each do |attribute|
      it "sets #{attribute} if the hash contains #{attribute}" do
        game = Game.new({ attribute => ['foo', 'bar'] })
        expect(game.send(attribute).size).to eq 2
      end

      it "sets #{attribute} if the hash contains #{camelize attribute}" do
        game = Game.new({ camelize(attribute) => ['foo', 'bar'] })
        expect(game.send(attribute).size).to eq 2
      end

      it 'raises an error if the value is not enumerable' do
        expect { Game.new({ attribute => 'asd' }) }.to raise_error NoMethodError
      end

      pending 'parses the collection converting each value in an object'
    end

    context 'when createDate attribute is present' do
      it 'sets the create_date attribute parsing the epoch' do
        game = Game.new 'createDate' => 123
        expect(game.create_date).to be_a DateTime
      end

      pending 'does not raise error if the attribute value is a DateTime object'
    end

    context 'when createDate attribute is absent' do
      it 'does not set the create_date attribute' do
        game = Game.new
        expect(game.create_date).to be_nil
      end
    end
  end

  describe 'attributes' do
    %w(champion_id create_date create_date_str fellow_players game_id game_mode game_type invalid level map_id spell1 spell2 statistics sub_type team_id).each do |attribute|
      it "##{attribute} has its own reader" do
        expect(subject).to respond_to attribute
      end

      it "##{attribute} cannot be set" do
        expect(subject).to_not respond_to "#{attribute}="
      end
    end
  end
end
