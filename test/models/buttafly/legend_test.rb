require 'test_helper'

describe Buttafly::Legend do

  subject { Buttafly::Legend }

  describe "db" do

    specify "columns & types" do

      must_have_column(:data, :text)
      must_have_column(:targetable_model)
      must_have_column(:originable_headers)
    end
  end

  describe "associations" do

    specify "belongs to" do

      must_have_many(:mappings)
      must_have_many(:originables)
    end
  end

  describe "fixture" do

    Given(:legend) { buttafly_legends(:one) }
    Then { legend.data.first.first.must_equal "review" }
    And { legend.originable_headers.must_include "wine name" }
  end

  describe "default_name" do

    Given(:legend) { buttafly_legends(:one) }

    describe "uses targetable_model when name is absent" do

      Then { legend.default_name.must_equal "review" }
    end

    describe "uses name when present" do

      When { legend.update(name: "sweet name") }

      Then { legend.default_name.must_equal "sweet name" }
    end
    end

  # specify "has many :originables through :mappings" do
  #   legend = buttafly_legends(:one)
  #   legend.mappings.must_include buttafly_mappings(:one)
  #   legend.originables.must_include buttafly_spreadsheets(:review)
  # end


end
