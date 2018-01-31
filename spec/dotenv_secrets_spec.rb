RSpec.describe DotenvSecrets do
  it "has a version number" do
    expect(DotenvSecrets::VERSION).not_to be nil
  end

  describe "#[]" do
    let(:path) { File.join(File.dirname(__FILE__), "secrets.env") }

    subject(:secrets) { DotenvSecrets.new(path: path) }

    context "looking for a key that is in the file" do
      it "returns the value of the key" do
        expect(secrets["A_B"]).to eq "42"
      end
    end

    context "looking for a key that isn't in the file" do
      it "raises a EOFError" do
        expect { secrets["B_C"] }.to raise_error(EOFError, /B_C.*#{path}/)
      end
    end

    context "looking for a key whose value has an = in it" do
      it "returns the whole value correctly" do
        expect(secrets["TRICK_KEY"]).to eq "thisvaluehasa=insideit"
      end
    end
  end
end
