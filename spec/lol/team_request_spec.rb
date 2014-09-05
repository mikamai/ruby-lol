require "spec_helper"
require "lol"

include Lol

describe TeamRequest do
  let(:request) { TeamRequest.new("api_key", "euw") }

  it "inherits from Request" do
    expect(TeamRequest.ancestors[1]).to eq(Request)
  end

  describe "#by_summoner" do
    let(:fixture) { load_fixture('by-summoner', TeamRequest.api_version) }

    subject { request.by_summoner(1) }

    before(:each) { stub_request(request, 'by-summoner', 'team/by-summoner/1') }

    it 'returns an hash' do
      expect(subject).to be_a(Hash)
    end

    it 'fetches Team from the API' do
      expect(subject.size).to eq(fixture.size)
    end
  end

  describe "#get" do

    it 'requires a team id' do
      expect { request.get }.to raise_error
    end

    context 'with team id' do
      subject { request.get("TEAM-a9ad3db0-b377-11e3-b87d-782bcb4ce61a") }

      before(:each) { stub_request(request, 'team', 'team/TEAM-a9ad3db0-b377-11e3-b87d-782bcb4ce61a') }

      it 'returns an array of Teams' do
        subject.each {|k,v| expect(v).to be_a Lol::Team}
      end
    end

  end

end
