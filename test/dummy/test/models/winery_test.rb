require "test_helper"

describe Winery do

  describe "db" do

    specify "columns & types" do

      must_have_column(:name)
      must_have_column(:mission)
      must_have_column(:history)
      must_have_column(:owner_id, :integer)
    end
  end

  describe "associations" do
    specify "belongs to" do

      must_belong_to(:owner)
    end

    specify "has many" do

      must_have_many(:wines)
      must_have_many(:reviews)
    end
  end
end
