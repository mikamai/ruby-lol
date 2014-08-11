require "spec_helper"
require "lol"

include Lol

describe TeamRequest do
  let(:request) { TeamRequest.new("api_key", "euw") }

  it "inherits from Request" do
    expect(TeamRequest.ancestors[1]).to eq(Request)
  end

  describe "#get" do
    let(:fixture) { load_fixture('team', TeamRequest.api_version) }

    subject { request.get(1) }

    before(:each) { stub_request(request, 'team', 'team/by-summoner/1') }

    it 'returns an hash' do
      expect(subject).to be_a(Hash)
    end

    it 'returns an array of Team' do
      expect(subject[subject.keys.first].map(&:class).uniq).to eq([Team])
    end

    it 'fetches Team from the API' do
      expect(subject.size).to eq(fixture.size)
    end
  end

  describe "#getbyid" do

    it 'requires a summoner' do
      expect { request.getbyid }.to raise_error ArgumentError
    end

    context 'with summoner' do
      subject { request.getbyid("TEAM-a9ad3db0-b377-11e3-b87d-782bcb4ce61a") }

      before(:each) { stub_request(request, 'team-by-id', 'team/TEAM-a9ad3db0-b377-11e3-b87d-782bcb4ce61a') }

      it 'returns a Team' do
        expect(subject).to be_a Lol::Team
      end

      it 'fetches Team from the API' do
        expect(subject.full_id).to eq "TEAM-a9ad3db0-b377-11e3-b87d-782bcb4ce61a"
      end
    end

  end

end
