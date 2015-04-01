require "spec_helper"

describe PropertybaseId do
  subject do
    described_class.new(
      object_id: object_id,
      host_id: host_id,
      process_id: process_id,
      counter: counter,
      time: time,
    )
  end

  describe "#==" do
    let(:object_id) { 2 }
    let(:host_id) { "be" }
    let(:process_id) { "cl" }
    let(:counter) { "own" }
    let(:time) { 1427829234 }

    context "for equal ids" do
      let(:compare_to) do
        described_class.new(
          object_id: object_id,
          host_id: host_id,
          process_id: process_id,
          counter: counter,
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

    context "user" do
      let(:object) { "user" }

      it "returns user" do
        expect(subject.object).to eq(object)
      end
    end

    context "team" do
      let(:object) { "team" }

      it "returns team" do
        expect(subject.object).to eq(object)
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
    let(:input_id) { "#{object_id_36}#{host_id_36}#{time_36}#{process_id_36}#{counter_36}" }

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
        let(:input_id) { "00145678901234567" }

        it "raises argument error" do
          expect do
            described_class.parse(input_id)
          end.to raise_error(ArgumentError, /invalid length/)
        end
      end

      context "non existing object" do
        let(:input_id) { "zzz4567890123456" }

        it "raises argumen error" do
          expect do
            described_class.parse(input_id)
          end.to raise_error(ArgumentError, /No object to id zzz/)
        end
      end
    end

    context "valid ID" do
      let(:object_id) { 1 }
      let(:host_id) { 926 }
      let(:time) { 1427848726 }
      let(:process_id) { 892 }
      let(:counter) { 11 }

      let(:object_id_36) { "001" }
      let(:host_id_36) { "pq" }
      let(:time_36) { "nm3r4m" }
      let(:process_id_36) { "os" }
      let(:counter_36) { "00b" }

      it "returns correct ID" do
        expect(described_class.parse(input_id)).to eq(subject)
      end
    end
  end
end
