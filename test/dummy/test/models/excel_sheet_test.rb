require 'test_helper'

describe ExcelSheet do

  subject { ExcelSheet }

  describe "db" do

    specify "columns & types" do

      # must_have_column(:aasm_state)
    end
  end

  describe "associations" do

    specify "belongs to" do

      must_have_many(:mappings)
      must_have_many(:legends)
    end
  end

  describe "originable? must be true" do

    Then { subject.originable?.must_equal true}
  end

  specify "has many :legends, through: :mappings" do

    spreadsheet = excel_sheets(:review)
    spreadsheet.mappings.must_include buttafly_mappings(:excel_sheet_mapping)
    spreadsheet.legends.must_include buttafly_legends(:one)
  end

  specify do
    Buttafly.originable_model.must_equal "Buttafly::Spreadsheet"
    Buttafly.originable_model = "ExcelSheet"
    Buttafly.originable_model.must_equal "ExcelSheet"
  end
end
