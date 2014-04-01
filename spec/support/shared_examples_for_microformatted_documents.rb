shared_examples_for "a valid Microformats2 document" do
  let(:microformats_markup) { response.body }

  it "is a valid microformats document" do
    expect { Microformats2.parse(microformats_markup) }.to_not raise_error
  end
end
