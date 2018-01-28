require 'test_helper'

describe Buttafly::Mapping do

  subject { Buttafly::Mapping }

  describe "db" do

    specify "columns & types" do

      must_have_column(:legend_id, :integer)
      must_have_column(:originable_id, :integer)
      must_have_column(:originable_type)
    end

    specify "indexes" do

      must_have_index(["originable_id", "originable_type"])
    end

    specify "associations" do

      must_belong_to(:legend)
      must_belong_to(:originable)
    end
  end

  specify "can belong to a spreadsheet through polymorphism" do
    mapping = buttafly_mappings(:one)
    mapping.originable.class.name.must_equal "Buttafly::Spreadsheet"
    mapping.legend.class.name.must_equal "Buttafly::Legend"

  end
end
