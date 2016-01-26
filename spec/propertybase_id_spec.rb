require "spec_helper"

describe PropertybaseId do
  subject do
    described_class.new(
      object_id: object_id,
      time: time,
      random_int: random_int
    )
  end

  describe "#==" do
    let(:object_id) { 2 }
    let(:random_int) { 581698 }
    let(:time) { 1427829234 }

    context "for equal ids" do
      let(:compare_to) do
        described_class.new(
          object_id: object_id,
          random_int: random_int,
          time: time,
        )
      end

      it "returns true" do
        expect(subject).to eq(compare_to)
      end
    end
  end

  describe "#object" do
    subject { described_class.generate(object: object) }

    PropertybaseId::Mappings.objects.keys.each do |kind|
      context kind do
        let(:object) { kind }

        it "returns #{kind}" do
          expect(subject.object).to eq(object)
        end
      end
    end
  end

  describe ".generate" do
    context "wrong object" do
      it "raises exception for unknown object" do
        expect do
          described_class.generate(object: "streusselkuchen")
        end.to raise_error(ArgumentError)
      end
    end

    context "uniqueness" do
      context "single thread" do
        it "creates 2 different IDs" do
          expect(described_class.generate(object: "team")).not_to eq(described_class.generate(object: "team"))
        end
      end

      context "multi thread" do
        it "returns different ID" do
          id1 = nil
          id2 = nil

          t1 = Thread.new { id1 = described_class.generate(object: "user") }
          t2 = Thread.new { id2 = described_class.generate(object: "user") }

          t1.join
          t2.join

          expect(id1).not_to eq(id2)
        end
      end
    end
  end

  describe ".parse" do
    let(:input_id) { "#{object_id_36}#{time_36}#{random_str_36}" }

    context "invalid ID" do
      context "too short" do
        let(:input_id) { "123" }

        it "raises argument error" do
          expect do
            described_class.parse(input_id)
          end.to raise_error(ArgumentError, /invalid length/)
        end
      end

      context "too long" do
        let(:input_id) { "0014567890123456789" }

        it "raises argument error" do
          expect do
            described_class.parse(input_id)
          end.to raise_error(ArgumentError, /invalid length/)
        end
      end

      context "non existing object" do
        let(:input_id) { "zz4567891234567" }

        it "raises argumen error" do
          expect do
            described_class.parse(input_id)
          end.to raise_error(ArgumentError, /No object to id zz/)
        end
      end
    end

    context "valid ID" do
      let(:object_id) { 1 }
      let(:time) { 1427848726 }
      let(:random_int) { 11 }

      let(:object_id_36) { "01" }
      let(:time_36) { "0nm3r4m" }
      let(:random_str_36) { "00000b" }

      it "returns correct ID" do
        expect(described_class.parse(input_id)).to eq(subject)
      end
    end
  end
end
