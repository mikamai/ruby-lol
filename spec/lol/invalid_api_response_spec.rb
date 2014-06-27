require "spec_helper"
require "lol"

include Lol

describe InvalidAPIResponse do
  subject { InvalidAPIResponse.new "foo", "status" => { "message" => "bar"} }

  it "does not crash on initialization" do
    expect { subject }.not_to raise_error
  end

  it "assigns raw" do
    expect(subject.raw).not_to be_nil
  end

  context "when the received response is an hash with a 'status' key" do
    it "sets a certain message including the status message" do
      expect(subject.message).to match /^bar/
    end

    it "sets a certain message including the url" do
      expect(subject.message).to match /foo$/
    end
  end

  context "when the received response has no 'status' key" do
    subject { InvalidAPIResponse.new "foo", headers: {}, body: 'asd' }

    it "sets a certain message including 'Unknown Error'" do
      expect(subject.message).to match /^Unknown Error/
    end

    it "sets a certain message including the url" do
      expect(subject.message).to match /foo$/
    end
  end

  describe '#raw' do
    describe ':headers' do
      it 'equals to headers in the response hash' do
        subject = InvalidAPIResponse.new 'foo', OpenStruct.new(headers: { a: 1 })
        expect(subject.raw[:headers]).to eq a: 1
      end

      it 'equals an empty hash if response contain no headers' do
        subject = InvalidAPIResponse.new 'foo', OpenStruct.new
        expect(subject.raw[:headers]).to eq Hash.new
      end
    end

    describe ':body' do
      it 'equals to #parsed_response' do
        subject = InvalidAPIResponse.new 'foo', OpenStruct.new(parsed_response: 'a')
        expect(subject.raw[:body]).to eq 'a'
      end

      it 'equals to #body if response has no #parsed_response' do
        subject = InvalidAPIResponse.new 'foo', OpenStruct.new(body: 'a')
        expect(subject.raw[:body]).to eq 'a'
      end

      it 'equals to the response itself if response has no #body or #parsed_response' do
        r = OpenStruct.new
        expect(InvalidAPIResponse.new('foo', r).raw[:body]).to eq r
      end
    end

    describe ':status' do
      it 'equals to response status if response is an hash' do
        subject = InvalidAPIResponse.new 'foo', 'status' => { 'message' => 'a' }
        expect(subject.raw[:status]).to eq 'a'
      end

      it 'equals to Unknown Error otherwise' do
        subject = InvalidAPIResponse.new 'foo', OpenStruct.new
        expect(subject.raw[:status]).to eq 'Unknown Error'
      end
    end
  end
end
