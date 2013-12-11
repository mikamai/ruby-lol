require "lol"
require "spec_helper"

include Lol

describe Client do
  describe "#new" do
    it "requires an API key argument" do
      expect { Client.new }.to raise_error(ArgumentError)
    end

    it "accepts a region argument" do
      expect { Client.new("foo", :region => "NA") }.not_to raise_error
    end

    it "defaults on EUW as a region" do
      expect(Client.new("foo").region).to eq("EUW")
    end
  end

  describe "#champion" do
    it "defaults to v1.1" do
      pending
    end
  end

  describe "#champions11" do
    it "returns all champions" do
      pending
    end
  end
end
