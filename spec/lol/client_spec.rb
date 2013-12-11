require "lol"
require "spec_helper"

include Lol

describe Client do
  describe "#new" do
    it "requires an API key argument" do
      expect { Proc.new { Client.new } }.to raise_error
    end
  end
end
