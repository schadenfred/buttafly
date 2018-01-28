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
      must_have_many(:originables)
    end
  end

  specify "has many :originables through :mappings" do
skip
    legend = buttafly_legends(:one)
    legend.mappings.must_include buttafly_mappings(:one)
    legend.originables.must_include buttafly_spreadsheets(:review)
  end
end
