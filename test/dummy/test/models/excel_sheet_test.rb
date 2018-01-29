require 'test_helper'

describe ExcelSheet do

  subject { ExcelSheet }

  describe "db" do

    specify "columns & types" do

      must_have_column(:aasm_state)
      must_have_column(:custom_state)
      must_have_column(:sheet)
    end
  end

  specify "has many :legends, through: :mappings" do

    spreadsheet = excel_sheets(:review)
    spreadsheet.mappings.must_include buttafly_mappings(:excel_sheets_mapping)
    spreadsheet.legends.must_include buttafly_legends(:one)
  end
end
