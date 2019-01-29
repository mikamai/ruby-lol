require "spec_helper"
require "lol"

include Lol

describe SummonerRequest do
  subject { SummonerRequest.new "api_key", "euw" }
  let(:encrypted_id) { 'qHn0uNkpA1T-NqQ0zHTEqNh1BhH5SAsGWwkZsacbeKBqSdkUEaYOcYNjDomm60vMrLWHu4ulYg1C5Q' }

  it "inherits from Request" do
    expect(SummonerRequest).to be < Request
  end

  describe "#find" do
    it "returns a DynamicModel" do
      stub_request subject, "summoner", "summoners/#{encrypted_id}"
      expect(subject.find encrypted_id).to be_a DynamicModel
    end
  end

  describe "#find_by_name" do
    it "returns a DynamicModel" do
      stub_request subject, 'summoner', 'summoners/by-name/foo'
      expect(subject.find_by_name 'foo').to be_a DynamicModel
    end

    it "escapes the given name" do
      stub_request subject, 'summoner', 'summoners/by-name/f%C3%B2%C3%A5'
      subject.find_by_name 'fòå'
    end

    it "downcases the given name" do
      stub_request subject, 'summoner', 'summoners/by-name/arg'
      subject.find_by_name 'ARG'
    end

    it 'strips spaces from names' do
      stub_request(subject, 'summoner', 'summoners/by-name/foo')
      subject.find_by_name('fo o')
    end
  end

  describe "#find_by_account_id" do
    it "returns a DynamicModel" do
      stub_request subject, "summoner", "summoners/by-account/#{encrypted_id}"
      expect(subject.find_by_account_id encrypted_id).to be_a DynamicModel
    end
  end

  describe "#find_by_puuid" do
    it "returns a DynamicModel" do
      stub_request subject, "summoner", "summoners/by-puuid/#{encrypted_id}"
      expect(subject.find_by_puuid encrypted_id).to be_a DynamicModel
    end
  end
end
