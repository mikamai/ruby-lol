require "spec_helper"
require "lol"

include Lol

describe TournamentProviderRequest do
  it "inherits from Request" do
    expect(TournamentProviderRequest.ancestors[1]).to eq(Request)
  end

  let(:request) { TournamentProviderRequest.new("api_key", "euw") }

  describe "#api_url" do
    subject { request.api_url "foo/bar"}

    it "matches the tournament api paths" do
      expect(subject).to eq("https://global.api.pvp.net/tournament/public/#{TournamentProviderRequest.api_version}/foo/bar")
    end
  end

  describe "#provider" do
    subject { request.provider("EUW", "https://foo.com") }

    before(:each) do
      expect(TournamentProviderRequest).to receive(:perform_request).and_return 10
    end

    it 'return the provider id' do
      expect(subject).to eq 10
    end
  end

  describe "#tournament" do
    subject { request.provider("test", 10) }

    before(:each) do
      expect(TournamentProviderRequest).to receive(:perform_request).and_return 20
    end

    it 'return the tournament provider id' do
      expect(subject).to eq 20
    end
  end

  describe "#get_code" do
    # Can't use stub_request for different api_url
    before(:each) do
      full_url = request.api_url "code/CODE-FOR-TEST?#{request.api_query_string}"
      fixture_json = load_fixture('get-code', TournamentProviderRequest.api_version)

      expect(TournamentProviderRequest).to receive(:get).with(full_url, instance_of(Hash)).and_return(fixture_json)
    end
    subject { request.get_code "CODE-FOR-TEST" }

    it 'returns a TournamentCode' do
      expect(subject).to be_a(Lol::TournamentCode)
    end
  end

  describe "#update_code" do
    let(:fixture) { load_fixture('get-code', TournamentProviderRequest.api_version) }

    it 'exclude nil options' do
      expect(request).to receive(:perform_request).once.ordered.with(
        instance_of(String),
        :put,
        { allowedParticipants: "1,2,3,4,5,6,7,8,9,10" }
      )
      expect(request).to receive(:perform_request).once.ordered.with(instance_of(String)).and_return(fixture)
      request.update_code "CODE-FOR-TEST", { allowed_participants: [1,2,3,4,5,6,7,8,9,10] }
    end
  end
end
