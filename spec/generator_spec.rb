require "spec_helper"

describe PropertybaseId::Generator do
  subject { described_class.new }

  describe "#generate" do
    include_examples "verifify for object", "User"
    include_examples "verifify for object", "Team"
  end
end
