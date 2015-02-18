require "spec_helper"

describe PropertybaseId do
  subject { described_class }

  describe ".create" do
    let(:object) { "user" }
    let(:server) { 1 }

    let(:opts) { { object: object, server: server } }

    it "returns a PropertybaseId object" do
      expect(subject.create(opts)).to be_a(PropertybaseId)
    end

    it "sets object" do
      expect(subject.create(opts).object).to eq(object)
    end

    it "sets server" do
      expect(subject.create(opts).server).to eq(server)
    end

    it "sets local random" do
      expect(subject.create(opts).local_random).not_to be_nil
    end
  end

  describe ".new" do
    subject{ described_class.new(object, server, local_random) }

    context "valid" do
      let(:object) { "user" }
      let(:server) { 1 }
      let(:local_random) { 164314242792474636 }

      it "does not raise error" do
        expect{ subject }.not_to raise_error
      end
    end

    context "non existing object" do
      let(:object) { "something_that_does_not_exist" }
      let(:server) { 1 }
      let(:local_random) { 241714242792682775 }

      it "raises an argument error" do
        expect{ subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".parse" do
    subject { described_class }

    context "valid" do
      context "user id" do
        let(:input_id) { "01012vd3f2emuc5e" }

        it "sets object to user" do
          expect(subject.parse(input_id).object).to eq("user")
        end

        it "sets server id" do
          expect(subject.parse(input_id).server).to eq(1)
        end

        it "sets local random" do
          expect(subject.parse(input_id).local_random).to eq(377914242793817858)
        end

        it "converts correctly to input" do
          expect(subject.parse(input_id).to_s).to eq(input_id)
        end
      end

      context "team id" do
        let(:input_id) { "020145yx6dq9zfo4" }

        it "sets object to user" do
          expect(subject.parse(input_id).object).to eq("team")
        end

        it "sets server id" do
          expect(subject.parse(input_id).server).to eq(1)
        end

        it "sets local random" do
          expect(subject.parse(input_id).local_random).to eq(548314242795100948)
        end

        it "converts correctly to input" do
          expect(subject.parse(input_id).to_s).to eq(input_id)
        end
      end

      context "valid" do
        context "unknown object" do
          let(:input_id) { "zz0145yx6dq9zfo4" }

          it "raises error" do
            expect { subject.parse(input_id) }.to raise_error(ArgumentError)
          end
        end
      end
    end
  end

  describe "#to_s" do
    subject { described_class.new("user", 1, 501714242792241327) }

    it "returns a string" do
      expect(subject.to_s).to be_a(String)
    end

    it "returns expected string" do
      expect(subject.to_s).to eq("01013t82ut9kmkdr")
    end
  end
end
