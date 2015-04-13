shared_examples "verifify for object" do | object |
  context object do

    context "as string" do
      it "generates valid Propertybase ID" do
        id_str = subject.generate(object: object.downcase).to_s
        expect(PropertybaseId.parse(id_str)).to be_a(PropertybaseId)
      end
    end

    context "as symbol" do
      it "generates valid Propertybase ID" do
        id_str = subject.generate(object: object.downcase.to_sym).to_s
        expect(PropertybaseId.parse(id_str)).to be_a(PropertybaseId)
      end
    end
  end
end
