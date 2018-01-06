require "test_helper"

describe Review do

  describe "associations" do

    specify "belongs to" do

      must_belong_to(:reviewer)
      must_belong_to(:wine)
      must_belong_to(:winery)
    end
  end
end
