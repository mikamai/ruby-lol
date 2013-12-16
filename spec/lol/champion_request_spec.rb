require "spec_helper"
require "lol"

describe ChampionRequest do
  it "requires an api_key parameter" do
    expect { ChampionRequest.new }.to raise_error(ArgumentError)
  end
end
