require "test_helper"

describe Winery do
  let(:winery) { Winery.new }

  it "must be valid" do
    value(winery).must_be :valid?
  end
end
