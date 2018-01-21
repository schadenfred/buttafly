require "test_helper"

describe User do

  describe "db" do

    specify "columns & types" do

      must_have_column(:name)
    end
  end

  describe "associations" do

    specify "has many" do

      must_have_many(:wines_made)
      must_have_many(:wineries_owned)
      must_have_many(:reviews)
    end
  end
end
