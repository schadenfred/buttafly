require "test_helper"

describe Wine do
  let(:wine) { Wine.new }

  it "must be valid" do
    value(wine).must_be :valid?
  end
end
