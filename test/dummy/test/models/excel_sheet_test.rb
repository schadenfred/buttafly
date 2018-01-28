require 'test_helper'

describe ExcelSheet do

  subject { ExcelSheet }

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
skip
    spreadsheet = excel_sheets(:review)
    spreadsheet.mappings.must_include buttafly_mappings(:twoone)
    spreadsheet.legends.must_include buttafly_legends(:one)
  end





end
