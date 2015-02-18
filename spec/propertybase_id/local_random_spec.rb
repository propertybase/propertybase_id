require "spec_helper"
require "propertybase_id/local_random"

describe PropertybaseId::LocalRandom do
  subject { described_class.new(time) }
  let(:time) { Time.at(1424272397.298489) }

  it "creates a LocalRandom" do
    expect(subject).to be_a(PropertybaseId::LocalRandom)
  end

  describe "#to_i" do
    it "returns an integer" do
      expect(subject.to_i).to be_a(Integer)
    end

    it "always returns the same number for same instance" do
      expect(subject.to_i).to eq(subject.to_i)
    end
  end
end
