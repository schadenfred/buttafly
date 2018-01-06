require "test_helper"

describe Wine do

  subject { Wine }

  describe "associations" do

    specify "belongs to" do

      must_belong_to(:winery)
      must_have_many(:reviews)
    end
  end
end
