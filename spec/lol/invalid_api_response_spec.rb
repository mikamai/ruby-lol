require "spec_helper"
require "lol"

include Lol

describe InvalidAPIResponse do
  subject { InvalidAPIResponse.new "foo", {"status" => "foo", "message" => "bar"} }
  it "does not crash on initialization" do
    expect { subject }.not_to raise_error
  end

  it "assigns raw" do
    expect(subject.raw).not_to be_nil
  end
end
