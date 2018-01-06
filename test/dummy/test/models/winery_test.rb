require "test_helper"

describe Winery do

  describe "associations" do

    specify "has many" do

      must_have_many(:wines)
      must_have_many(:reviews)
    end
  end
end
