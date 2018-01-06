require 'test_helper'

describe Buttafly::Legend do

  subject { Buttafly::Legend }

  describe "db" do

    specify "columns & types" do

      must_have_column(:data, :text)
      must_have_column(:targetable_model)
    end
  end

  describe "associations" do

    specify "belongs to" do

      must_have_many(:mappings)
    end
  end
end
